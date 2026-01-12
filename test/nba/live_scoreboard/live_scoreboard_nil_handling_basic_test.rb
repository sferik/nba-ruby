require_relative "../../test_helper"
require_relative "../../support/live_scoreboard_test_helpers"

module NBA
  class LiveScoreboardNilHandlingBasicTest < Minitest::Test
    include LiveScoreboardTestHelpers

    cover LiveScoreboard

    # Test that missing game_id key returns nil instead of raising
    def test_handles_missing_game_id_key
      stub_response_without("gameId")

      game = LiveScoreboard.today.first

      assert_nil game.game_id
    end

    # Test that missing game_code key returns nil instead of raising
    def test_handles_missing_game_code_key
      stub_response_without("gameCode")

      game = LiveScoreboard.today.first

      assert_nil game.game_code
    end

    # Test that missing game_status key returns nil instead of raising
    def test_handles_missing_game_status_key
      stub_response_without("gameStatus")

      game = LiveScoreboard.today.first

      assert_nil game.game_status
    end

    # Test that missing game_status_text key returns nil instead of raising
    def test_handles_missing_game_status_text_key
      stub_response_without("gameStatusText")

      game = LiveScoreboard.today.first

      assert_nil game.game_status_text
    end

    # Test that missing period key returns nil instead of raising
    def test_handles_missing_period_key
      stub_response_without("period")

      game = LiveScoreboard.today.first

      assert_nil game.period
    end

    # Test that missing game_clock key returns nil instead of raising
    def test_handles_missing_game_clock_key
      stub_response_without("gameClock")

      game = LiveScoreboard.today.first

      assert_nil game.game_clock
    end

    # Test that missing game_time_utc key returns nil instead of raising
    def test_handles_missing_game_time_utc_key
      stub_response_without("gameTimeUTC")

      game = LiveScoreboard.today.first

      assert_nil game.game_time_utc
    end

    # Test that missing game_et key returns nil instead of raising
    def test_handles_missing_game_et_key
      stub_response_without("gameEt")

      game = LiveScoreboard.today.first

      assert_nil game.game_et
    end

    # Test that missing homeTeam key returns nil values instead of raising
    def test_handles_missing_home_team_key
      stub_response_without("homeTeam")

      game = LiveScoreboard.today.first

      assert_nil game.home_team_id
      assert_nil game.home_team_name
      assert_nil game.home_team_city
      assert_nil game.home_team_tricode
      assert_nil game.home_team_score
    end

    # Test that missing awayTeam key returns nil values instead of raising
    def test_handles_missing_away_team_key
      stub_response_without("awayTeam")

      game = LiveScoreboard.today.first

      assert_nil game.away_team_id
      assert_nil game.away_team_name
      assert_nil game.away_team_city
      assert_nil game.away_team_tricode
      assert_nil game.away_team_score
    end
  end
end
