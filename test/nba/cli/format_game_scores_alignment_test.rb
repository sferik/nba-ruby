require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class FormatGameScoresAlignmentTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_scores_are_right_justified
      game = mock_game("Final", "Warriors", "Lakers", 91, 118)
      widths = {home_score: 3, away_score: 3}
      result = format_game_scores(game, widths)

      assert_equal " 91", result[:home]
      assert_equal "118", result[:away]
    end

    def test_home_score_right_justified_with_two_digits
      game = mock_game("Final", "Warriors", "Lakers", 91, 100)
      widths = {home_score: 3, away_score: 3}
      result = format_game_scores(game, widths)

      assert_equal " 91", result[:home]
    end

    def test_away_score_right_justified_with_two_digits
      game = mock_game("Final", "Warriors", "Lakers", 100, 91)
      widths = {home_score: 3, away_score: 3}
      result = format_game_scores(game, widths)

      assert_equal " 91", result[:away]
    end

    def test_scores_not_centered
      game = mock_game("Final", "Warriors", "Lakers", 91, 118)
      widths = {home_score: 5, away_score: 5}
      result = format_game_scores(game, widths)

      refute_equal "  91 ", result[:home]
      assert_equal "   91", result[:home]
    end
  end
end
