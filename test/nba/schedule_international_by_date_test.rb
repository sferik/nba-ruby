require_relative "../test_helper"

module NBA
  class ScheduleInternationalByDateTest < Minitest::Test
    cover ScheduleInternational

    def test_by_date_returns_collection
      stub_schedule_international_request

      result = ScheduleInternational.by_date(date: Date.new(2024, 10, 22))

      assert_instance_of Collection, result
    end

    def test_by_date_filters_games_by_date
      stub_schedule_international_request

      result = ScheduleInternational.by_date(date: Date.new(2024, 10, 22))

      assert_equal 1, result.size
      assert_equal "0022400001", result.first.game_id
    end

    def test_by_date_returns_empty_collection_when_no_games_on_date
      stub_schedule_international_request

      result = ScheduleInternational.by_date(date: Date.new(2024, 12, 25))

      assert_empty result
    end

    def test_by_date_handles_nil_game_date
      response = {leagueSchedule: {gameDates: [{games: [
        {gameId: "0022400001", gameDateTimeUTC: nil, homeTeam: {}, awayTeam: {}}
      ]}]}}
      stub_request(:get, /scheduleleaguev2int/).to_return(body: response.to_json)

      result = ScheduleInternational.by_date(date: Date.new(2024, 10, 22))

      assert_empty result
    end

    def test_by_date_forwards_season_parameter
      stub_request(:get, /scheduleleaguev2int.*Season=2022-23/)
        .to_return(body: schedule_international_response.to_json)

      ScheduleInternational.by_date(date: Date.new(2024, 10, 22), season: 2022)

      assert_requested :get, /scheduleleaguev2int.*Season=2022-23/
    end

    def test_by_date_forwards_league_parameter
      stub_request(:get, /scheduleleaguev2int.*LeagueID=10/)
        .to_return(body: schedule_international_response.to_json)

      ScheduleInternational.by_date(date: Date.new(2024, 10, 22), league: League::WNBA)

      assert_requested :get, /scheduleleaguev2int.*LeagueID=10/
    end

    def test_by_date_default_league_is_nba
      stub_request(:get, /scheduleleaguev2int.*LeagueID=00/)
        .to_return(body: schedule_international_response.to_json)

      ScheduleInternational.by_date(date: Date.new(2024, 10, 22))

      assert_requested :get, /scheduleleaguev2int.*LeagueID=00/
    end

    def test_by_date_forwards_client_parameter
      custom_client = Minitest::Mock.new
      custom_client.expect :get, schedule_international_response.to_json, [String]

      ScheduleInternational.by_date(date: Date.new(2024, 10, 22), client: custom_client)

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
