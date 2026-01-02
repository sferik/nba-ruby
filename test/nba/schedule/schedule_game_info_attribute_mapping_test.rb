require_relative "../../test_helper"

module NBA
  class ScheduleGameInfoAttributeMappingTest < Minitest::Test
    cover Schedule

    def test_maps_all_game_info_attributes
      stub_schedule_request

      game = Schedule.all.first

      assert_equal "2024-10-22T19:00:00Z", game.game_date
      assert_equal "0022400001", game.game_id
      assert_equal "20241022/LALGSW", game.game_code
      assert_equal 1, game.game_status
      assert_equal "7:00 pm ET", game.game_status_text
    end

    private

    def stub_schedule_request
      stub_request(:get, /scheduleleaguev2/).to_return(body: schedule_response.to_json)
    end

    def schedule_response
      {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game_data]}]}}
    end

    def game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001", gameCode: "20241022/LALGSW",
       gameStatus: 1, gameStatusText: "7:00 pm ET", homeTeam: home_team_data, awayTeam: away_team_data,
       arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA",
       broadcasters: {nationalTvBroadcasters: [{broadcasterDisplay: "TNT"}]}}
    end

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State", teamTricode: "GSW", wins: 46, losses: 36, score: 112}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles", teamTricode: "LAL", wins: 43, losses: 39, score: 108}
    end
  end
end
