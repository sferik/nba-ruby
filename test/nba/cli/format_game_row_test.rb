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
      game = mock_game("Final", "Warriors", "Lkrs", 118, 109)
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

      # Verify scores are in correct positions (home before colon, away after)
      assert_match(/118\s*:/, result)
    end

    def test_accesses_away_score_from_scores_hash
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)
      widths = {status: 5, home: 8, away: 6, home_score: 3, away_score: 3}
      result = format_game_row(game, widths)

      # Verify scores are in correct positions (away after colon)
      assert_match(/:\s*109/, result)
    end
  end
end
