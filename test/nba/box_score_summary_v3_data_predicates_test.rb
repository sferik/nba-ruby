require_relative "../test_helper"

module NBA
  class BoxScoreSummaryV3DataPredicatesTest < Minitest::Test
    cover BoxScoreSummaryV3Data

    def test_final_returns_true_when_game_status_is_final
      assert_predicate BoxScoreSummaryV3Data.new(game_status: 3), :final?
    end

    def test_final_returns_false_when_game_status_is_in_progress
      refute_predicate BoxScoreSummaryV3Data.new(game_status: 2), :final?
    end

    def test_final_returns_false_when_game_status_is_nil
      refute_predicate BoxScoreSummaryV3Data.new(game_status: nil), :final?
    end

    def test_in_progress_returns_true_when_game_status_is_live
      assert_predicate BoxScoreSummaryV3Data.new(game_status: 2), :in_progress?
    end

    def test_in_progress_returns_false_when_game_status_is_final
      refute_predicate BoxScoreSummaryV3Data.new(game_status: 3), :in_progress?
    end

    def test_in_progress_returns_false_when_game_status_is_nil
      refute_predicate BoxScoreSummaryV3Data.new(game_status: nil), :in_progress?
    end

    def test_scheduled_returns_true_when_game_status_is_not_started
      assert_predicate BoxScoreSummaryV3Data.new(game_status: 1), :scheduled?
    end

    def test_scheduled_returns_false_when_game_status_is_final
      refute_predicate BoxScoreSummaryV3Data.new(game_status: 3), :scheduled?
    end

    def test_scheduled_returns_false_when_game_status_is_nil
      refute_predicate BoxScoreSummaryV3Data.new(game_status: nil), :scheduled?
    end
  end
end
