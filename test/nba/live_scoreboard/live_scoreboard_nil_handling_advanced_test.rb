require_relative "../../test_helper"
require_relative "../../support/live_scoreboard_test_helpers"

module NBA
  class LiveScoreboardNilHandlingAdvancedTest < Minitest::Test
    include LiveScoreboardTestHelpers

    cover LiveScoreboard

    # Test that missing teamId in homeTeam returns nil instead of raising
    def test_handles_missing_home_team_id_key
      stub_response_with_missing_home_team_key("teamId")

      game = LiveScoreboard.today.first

      assert_nil game.home_team_id
    end

    # Test that missing teamName in homeTeam returns nil instead of raising
    def test_handles_missing_home_team_name_key
      stub_response_with_missing_home_team_key("teamName")

      game = LiveScoreboard.today.first

      assert_nil game.home_team_name
    end

    # Test that missing teamCity in homeTeam returns nil instead of raising
    def test_handles_missing_home_team_city_key
      stub_response_with_missing_home_team_key("teamCity")

      game = LiveScoreboard.today.first

      assert_nil game.home_team_city
    end

    # Test that missing teamTricode in homeTeam returns nil instead of raising
    def test_handles_missing_home_team_tricode_key
      stub_response_with_missing_home_team_key("teamTricode")

      game = LiveScoreboard.today.first

      assert_nil game.home_team_tricode
    end

    # Test that missing score in homeTeam returns nil instead of raising
    def test_handles_missing_home_team_score_key
      stub_response_with_missing_home_team_key("score")

      game = LiveScoreboard.today.first

      assert_nil game.home_team_score
    end

    # Test that missing teamId in awayTeam returns nil instead of raising
    def test_handles_missing_away_team_id_key
      stub_response_with_missing_away_team_key("teamId")

      game = LiveScoreboard.today.first

      assert_nil game.away_team_id
    end

    # Test that missing teamName in awayTeam returns nil instead of raising
    def test_handles_missing_away_team_name_key
      stub_response_with_missing_away_team_key("teamName")

      game = LiveScoreboard.today.first

      assert_nil game.away_team_name
    end

    # Test that missing teamCity in awayTeam returns nil instead of raising
    def test_handles_missing_away_team_city_key
      stub_response_with_missing_away_team_key("teamCity")

      game = LiveScoreboard.today.first

      assert_nil game.away_team_city
    end

    # Test that missing teamTricode in awayTeam returns nil instead of raising
    def test_handles_missing_away_team_tricode_key
      stub_response_with_missing_away_team_key("teamTricode")

      game = LiveScoreboard.today.first

      assert_nil game.away_team_tricode
    end

    # Test that missing score in awayTeam returns nil instead of raising
    def test_handles_missing_away_team_score_key
      stub_response_with_missing_away_team_key("score")

      game = LiveScoreboard.today.first

      assert_nil game.away_team_score
    end
  end
end
