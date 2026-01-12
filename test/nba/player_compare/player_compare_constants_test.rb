require_relative "../../test_helper"

module NBA
  class PlayerCompareConstantsTest < Minitest::Test
    cover PlayerCompare

    def test_overall_compare_constant
      assert_equal "OverallCompare", PlayerCompare::OVERALL_COMPARE
    end

    def test_regular_season_constant
      assert_equal "Regular Season", PlayerCompare::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", PlayerCompare::PLAYOFFS
    end
  end
end
