require_relative "../../test_helper"

module NBA
  class ScheduleAllTest < Minitest::Test
    cover Schedule

    def test_all_returns_collection
      stub_schedule_request

      assert_instance_of Collection, Schedule.all
    end

    def test_all_uses_correct_league_id_in_path
      stub_schedule_request

      Schedule.all

      assert_requested :get, /scheduleleaguev2.*LeagueID=00/
    end

    def test_all_parses_games_successfully
      stub_schedule_request

      games = Schedule.all

      assert_equal 1, games.size
      assert_equal "Warriors", games.first.home_team_name
    end

    def test_all_accepts_league_object
      stub_schedule_request
      league = League.new(id: "10", name: "WNBA")

      Schedule.all(league: league)

      assert_requested :get, /scheduleleaguev2.*LeagueID=10/
    end

    private

    def stub_schedule_request
      stub_request(:get, /scheduleleaguev2/).to_return(body: schedule_response.to_json)
    end

    def schedule_response
      {leagueSchedule: {gameDates: [
        {gameDate: "2024-10-22", games: [game_data]}
      ]}}
    end

    def game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001", gameCode: "20241022/LALGSW",
       gameStatus: 1, gameStatusText: "7:00 pm ET", homeTeam: home_team_data, awayTeam: away_team_data,
       arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA",
       broadcasters: {nationalTvBroadcasters: [{broadcasterDisplay: "TNT"}]}}
    end

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State", teamTricode: "GSW", wins: 0, losses: 0, score: 0}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles", teamTricode: "LAL", wins: 0, losses: 0, score: 0}
    end
  end
end
