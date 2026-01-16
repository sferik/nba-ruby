require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class FormatGameRowTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_includes_status
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}

      assert_includes format_game_row(game, widths), "Final"
    end

    def test_includes_teams
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}
      result = format_game_row(game, widths)

      assert_includes result, "Warriors"
      assert_includes result, "Lakers"
    end

    def test_includes_scores
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}
      result = format_game_row(game, widths)

      assert_includes result, "118"
      assert_includes result, "109"
    end

    def test_includes_colon_separator
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}

      assert_includes format_game_row(game, widths), ":"
    end

    def test_strips_trailing_whitespace
      # Home team is now in second column (right side), so make it shorter than width
      # Home team must lose so no green highlighting wraps the trailing whitespace
      game = mock_game("Final", "Lkrs", "Lakers", 109, 118)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}

      refute_match(/\s$/, format_game_row(game, widths))
    end

    def test_accesses_home_from_teams_hash
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}
      result = format_game_row(game, widths)

      # Should include "Warriors" not the hash representation
      assert_includes result, "Warriors"
      refute_includes result, "=>"
    end

    def test_accesses_away_from_teams_hash
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}
      result = format_game_row(game, widths)

      # Should include "Lakers" not the hash representation
      assert_includes result, "Lakers"
      refute_includes result, "home:"
    end

    def test_accesses_home_score_from_scores_hash
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}
      result = format_game_row(game, widths)

      # Verify scores are in correct positions (home after colon, may have ANSI codes)
      assert_match(/:.*118/, result)
    end

    def test_accesses_away_score_from_scores_hash
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}
      result = format_game_row(game, widths)

      # Verify scores are in correct positions (away before colon)
      assert_match(/109.*:/, result)
    end

    def test_away_team_in_first_column_home_team_in_second
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}
      result = format_game_row(game, widths)

      # Away team (Lakers) should appear before colon, home team (Warriors) after
      assert_match(/Lakers.*:.*Warriors/, result)
    end
  end
end
