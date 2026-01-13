require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class ScoreWidthsTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_home_score_uses_max_length
      game1 = mock_game("Final", "Jazz", "Lakers", 100, 90)
      game2 = mock_game("Final", "Warriors", "Celtics", 9, 88)
      widths = score_widths([game1, game2])

      assert_equal 3, widths[:home_score]
    end

    def test_away_score_uses_max_length
      game1 = mock_game("Final", "Jazz", "Lakers", 100, 90)
      game2 = mock_game("Final", "Warriors", "Celtics", 110, 8)
      widths = score_widths([game1, game2])

      assert_equal 2, widths[:away_score]
    end

    def test_handles_nil_scores
      game1 = mock_game("Scheduled", "Jazz", "Lakers", nil, nil)
      widths = score_widths([game1])

      assert_equal 0, widths[:home_score]
      assert_equal 0, widths[:away_score]
    end

    def test_converts_home_score_to_string
      # Create a game where home_score is an integer
      game1 = mock_game("Final", "Jazz", "Lakers", 100, 90)
      # Create a game with a larger integer score to verify max_length works on strings
      game2 = mock_game("Final", "Warriors", "Celtics", 9, 88)

      widths = score_widths([game1, game2])

      # The width should be based on the string length of the max score
      # max(100.to_s.length, 9.to_s.length) = max(3, 1) = 3
      assert_equal 3, widths[:home_score]
    end

    def test_converts_away_score_to_string
      # Create games where away_score is an integer
      game1 = mock_game("Final", "Jazz", "Lakers", 100, 90)
      game2 = mock_game("Final", "Warriors", "Celtics", 110, 8)

      widths = score_widths([game1, game2])

      # The width should be based on the string length of the max score
      # max(90.to_s.length, 8.to_s.length) = max(2, 1) = 2
      assert_equal 2, widths[:away_score]
    end

    def test_to_s_required_for_max_length_calculation
      # Verify that without .to_s, max_length wouldn't work on integers
      game = mock_game("Final", "Jazz", "Lakers", 100, 90)
      widths = score_widths([game])

      # This would fail if we passed integers directly to max_length
      # because max_length expects string or string-like objects
      assert_equal 3, widths[:home_score]
      assert_equal 2, widths[:away_score]
    end
  end
end
