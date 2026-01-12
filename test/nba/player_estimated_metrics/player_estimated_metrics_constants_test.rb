require_relative "../../test_helper"

module NBA
  class PlayerEstimatedMetricsConstantsTest < Minitest::Test
    cover PlayerEstimatedMetrics

    def test_regular_season_constant
      assert_equal "Regular Season", PlayerEstimatedMetrics::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", PlayerEstimatedMetrics::PLAYOFFS
    end

    def test_result_set_name_constant
      assert_equal "PlayerEstimatedMetrics", PlayerEstimatedMetrics::RESULT_SET_NAME
    end
  end
end
