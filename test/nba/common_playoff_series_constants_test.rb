require_relative "../test_helper"

module NBA
  class CommonPlayoffSeriesConstantsTest < Minitest::Test
    cover CommonPlayoffSeries

    def test_playoff_series_constant
      assert_equal "PlayoffSeries", CommonPlayoffSeries::PLAYOFF_SERIES
    end
  end
end
