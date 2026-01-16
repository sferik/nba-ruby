require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class FinalPredicateTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_final_returns_true_when_status_is_final
      game = mock_game("Final", "Warriors", "Lakers", 118, 109)

      assert final?(game)
    end

    def test_final_returns_true_when_status_starts_with_final
      game = mock_game("Final/OT", "Warriors", "Lakers", 118, 109)

      assert final?(game)
    end

    def test_final_returns_false_when_game_in_progress
      game = mock_game("Q4 2:30", "Warriors", "Lakers", 118, 109)

      refute final?(game)
    end

    def test_final_returns_false_when_game_scheduled
      game = mock_game("7:30 PM ET", "Warriors", "Lakers", nil, nil)

      refute final?(game)
    end

    def test_final_returns_false_when_status_is_nil
      game = mock_game(nil, "Warriors", "Lakers", nil, nil)

      refute final?(game)
    end

    def test_final_returns_false_not_nil_when_status_is_nil
      game = mock_game(nil, "Warriors", "Lakers", nil, nil)

      assert_same false, final?(game)
    end

    def test_final_uses_start_with_for_status_check
      game = mock_game("Finalized", "Warriors", "Lakers", 118, 109)

      assert final?(game)
    end
  end
end
