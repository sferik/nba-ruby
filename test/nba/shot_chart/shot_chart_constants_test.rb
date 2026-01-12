require_relative "../../test_helper"

module NBA
  class ShotChartConstantsTest < Minitest::Test
    cover ShotChart

    def test_result_set_name_constant
      assert_equal "Shot_Chart_Detail", ShotChart::RESULT_SET_NAME
    end
  end
end
