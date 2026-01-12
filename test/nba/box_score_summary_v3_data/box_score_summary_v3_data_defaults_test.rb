require_relative "../../test_helper"

module NBA
  class BoxScoreSummaryV3DataDefaultsTest < Minitest::Test
    cover BoxScoreSummaryV3Data

    def test_default_officials_is_empty_array
      assert_empty BoxScoreSummaryV3Data.new.officials
    end
  end
end
