require_relative "../../test_helper"

module NBA
  class BoxScoreSummaryV2ConstantsTest < Minitest::Test
    cover BoxScoreSummaryV2

    def test_game_summary_constant
      assert_equal "GameSummary", BoxScoreSummaryV2::GAME_SUMMARY
    end

    def test_line_score_constant
      assert_equal "LineScore", BoxScoreSummaryV2::LINE_SCORE
    end

    def test_officials_constant
      assert_equal "Officials", BoxScoreSummaryV2::OFFICIALS
    end

    def test_other_stats_constant
      assert_equal "OtherStats", BoxScoreSummaryV2::OTHER_STATS
    end
  end
end
