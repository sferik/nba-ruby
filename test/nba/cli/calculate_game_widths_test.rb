require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class CalculateGameWidthsTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_status_uses_max_status_length
      game1 = mock_game("Final", "GSW", "LAL", 100, 90)
      game2 = mock_game("In Progress", "BOS", "MIA", 50, 48)
      widths = calculate_game_widths([game1, game2])

      assert_equal 11, widths[:status]
    end

    def test_home_uses_max_home_team_length
      game1 = mock_game("Final", "Jazz", "Lakers", 100, 90)
      game2 = mock_game("Final", "Warriors", "Celtics", 110, 100)
      widths = calculate_game_widths([game1, game2])

      assert_equal 8, widths[:home]
    end

    def test_away_uses_max_away_team_length
      game1 = mock_game("Final", "Jazz", "Lakers", 100, 90)
      game2 = mock_game("Final", "Warriors", "Celtics", 110, 100)
      widths = calculate_game_widths([game1, game2])

      assert_equal 7, widths[:away]
    end

    def test_score_widths_included
      game1 = mock_game("Final", "Jazz", "Lakers", 100, 90)
      widths = calculate_game_widths([game1])

      assert widths.key?(:home_score)
      assert widths.key?(:away_score)
    end
  end
end
