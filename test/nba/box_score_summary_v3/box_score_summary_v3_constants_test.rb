require_relative "../../test_helper"

module NBA
  class BoxScoreSummaryV3ConstantsTest < Minitest::Test
    cover BoxScoreSummaryV3

    def test_box_score_summary_constant
      assert_equal "boxScoreSummary", BoxScoreSummaryV3::BOX_SCORE_SUMMARY
    end

    def test_box_score_summary_constant_is_frozen
      assert_predicate BoxScoreSummaryV3::BOX_SCORE_SUMMARY, :frozen?
    end
  end
end
