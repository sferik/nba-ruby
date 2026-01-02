require_relative "../../test_helper"

module NBA
  class ScheduleMissingGameInfoKeysTest < Minitest::Test
    cover Schedule

    def test_handles_missing_game_date_time_utc
      assert_missing_game_key_returns_nil("gameDateTimeUTC", :game_date)
    end

    def test_handles_missing_game_id
      assert_missing_game_key_returns_nil("gameId", :game_id)
    end

    def test_handles_missing_game_code
      assert_missing_game_key_returns_nil("gameCode", :game_code)
    end

    def test_handles_missing_game_status
      assert_missing_game_key_returns_nil("gameStatus", :game_status)
    end

    def test_handles_missing_game_status_text
      assert_missing_game_key_returns_nil("gameStatusText", :game_status_text)
    end

    private

    def assert_missing_game_key_returns_nil(key, attribute)
      game = base_game_data.dup
      game.delete(key.to_sym)
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def base_game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001", gameCode: "20241022/LALGSW",
       gameStatus: 1, gameStatusText: "7:00 pm ET",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
       awayTeam: {teamId: Team::LAL, teamName: "Lakers"}}
    end
  end
end
