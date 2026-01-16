require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class WinnerHighlightingTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_winner_returns_true_for_home_team_when_home_wins
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)

      assert winner?(game, :home)
    end

    def test_winner_returns_false_for_home_team_when_away_wins
      game = mock_game("Final", "Warriors", "Lakers", 109, 118)

      refute winner?(game, :home)
    end

    def test_winner_returns_true_for_away_team_when_away_wins
      game = mock_game("Final", "Warriors", "Lakers", 109, 118)

      assert winner?(game, :away)
    end

    def test_winner_returns_false_for_away_team_when_home_wins
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)

      refute winner?(game, :away)
    end

    def test_winner_returns_false_when_game_not_final
      game = mock_game("Q4 2:30", "Warriors", "Lakers", 118, 109)

      refute winner?(game, :home)
      refute winner?(game, :away)
    end

    def test_winner_returns_false_when_scores_are_nil
      game = mock_game("Final", "Warriors", "Lakers", nil, nil)

      refute winner?(game, :home)
      refute winner?(game, :away)
    end

    def test_winner_returns_false_when_home_score_is_nil
      game = mock_game("Final", "Warriors", "Lakers", nil, 109)

      refute winner?(game, :home)
    end

    def test_winner_returns_false_when_away_score_is_nil
      game = mock_game("Final", "Warriors", "Lakers", 118, nil)

      refute winner?(game, :away)
    end

    def test_winner_uses_eql_for_side_comparison
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)

      # Should work with symbol :home
      assert winner?(game, :home)
    end

    def test_winner_uses_eql_for_home_side_check
      game = mock_game("Final", "Warriors", "Lakers", 109, 118)

      # :away is not equal to :home, so away team wins
      assert winner?(game, :away)
    end
  end
end
