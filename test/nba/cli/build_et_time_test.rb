require_relative "test_helper"

module NBA
  class BuildEtTimeTest < Minitest::Test
    include CLI::Formatters::TimeFormatters

    cover CLI::Formatters::TimeFormatters

    def test_creates_time_in_eastern_timezone
      result = build_et_time(19, 30)

      assert_equal 19, result.hour
      assert_equal 30, result.min
      assert_equal "-05:00", result.strftime("%:z")
    end

    def test_uses_today_date
      today = Date.today
      result = build_et_time(10, 0)

      assert_equal today.year, result.year
      assert_equal today.month, result.month
      assert_equal today.day, result.day
    end

    def test_month_matches_today
      today = Date.today
      result = build_et_time(10, 0)

      assert_equal today.month, result.month, "Month should match today's month"
    end

    def test_seconds_are_zero
      assert_equal 0, build_et_time(10, 30).sec
    end

    def test_month_parameter_is_used
      # Stub Date.today to return a specific date, then verify the month is actually used
      specific_date = Date.new(2024, 3, 15)
      Date.stub(:today, specific_date) do
        result = build_et_time(10, 0)

        assert_equal 3, result.month
      end
    end
  end
end
