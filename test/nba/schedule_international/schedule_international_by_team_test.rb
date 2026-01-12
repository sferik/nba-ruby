require_relative "../../test_helper"

module NBA
  class ScheduleInternationalByTeamTest < Minitest::Test
    cover ScheduleInternational

    def test_by_team_returns_collection
      stub_schedule_international_request

      result = ScheduleInternational.by_team(team: Team::GSW)

      assert_instance_of Collection, result
    end

    def test_by_team_filters_home_games
      stub_schedule_international_request

      result = ScheduleInternational.by_team(team: Team::GSW)

      assert_equal 1, result.size
      assert_equal "0022400001", result.first.game_id
    end

    def test_by_team_filters_away_games
      stub_schedule_international_request

      result = ScheduleInternational.by_team(team: Team::LAL)

      assert_equal 1, result.size
      assert_equal "0022400001", result.first.game_id
    end

    def test_by_team_returns_empty_collection_when_team_not_playing
      stub_schedule_international_request

      result = ScheduleInternational.by_team(team: Team::BOS)

      assert_empty result
    end

    def test_by_team_accepts_team_object
      stub_schedule_international_request
      team = Team.new(id: Team::GSW)

      result = ScheduleInternational.by_team(team: team)

      assert_equal 1, result.size
    end

    def test_by_team_forwards_season_parameter
      stub_request(:get, /scheduleleaguev2int.*Season=2022-23/)
        .to_return(body: schedule_international_response.to_json)

      ScheduleInternational.by_team(team: Team::GSW, season: 2022)

      assert_requested :get, /scheduleleaguev2int.*Season=2022-23/
    end

    def test_by_team_forwards_league_parameter
      stub_request(:get, /scheduleleaguev2int.*LeagueID=10/)
        .to_return(body: schedule_international_response.to_json)

      ScheduleInternational.by_team(team: Team::GSW, league: League::WNBA)

      assert_requested :get, /scheduleleaguev2int.*LeagueID=10/
    end

    def test_by_team_default_league_is_nba
      stub_request(:get, /scheduleleaguev2int.*LeagueID=00/)
        .to_return(body: schedule_international_response.to_json)

      ScheduleInternational.by_team(team: Team::GSW)

      assert_requested :get, /scheduleleaguev2int.*LeagueID=00/
    end

    def test_by_team_forwards_client_parameter
      custom_client = Minitest::Mock.new
      custom_client.expect :get, schedule_international_response.to_json, [String]

      ScheduleInternational.by_team(team: Team::GSW, client: custom_client)

      custom_client.verify
    end

    private

    def stub_schedule_international_request
      stub_request(:get, /scheduleleaguev2int/).to_return(body: schedule_international_response.to_json)
    end

    def schedule_international_response
      {leagueSchedule: {gameDates: [{games: [game_data]}]}}
    end

    def game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001", gameCode: "20241022/LALGSW",
       gameStatus: 1, gameStatusText: "7:00 pm ET",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State",
                  teamTricode: "GSW", wins: 0, losses: 0, score: nil},
       awayTeam: {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles",
                  teamTricode: "LAL", wins: 0, losses: 0, score: nil},
       arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA",
       broadcasters: {nationalTvBroadcasters: [{broadcasterDisplay: "TNT"}]}}
    end
  end
end
