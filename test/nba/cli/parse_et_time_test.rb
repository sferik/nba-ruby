require_relative "test_helper"
require_relative "time_formatters_test_helper"

module NBA
  class ParseEtTimeTest < Minitest::Test
    include CLI::Formatters::TimeFormatters

    cover CLI::Formatters::TimeFormatters

    def test_extracts_hour_correctly
      match = ET_TIME_PATTERN.match("7:30 pm ET")

      assert_equal 19, parse_et_time(match).hour
    end

    def test_extracts_minute_correctly
      match = ET_TIME_PATTERN.match("7:30 pm ET")

      assert_equal 30, parse_et_time(match).min
    end

    def test_am_hour_correctly
      match = ET_TIME_PATTERN.match("11:45 am ET")

      assert_equal 11, parse_et_time(match).hour
    end

    def test_am_minute_correctly
      match = ET_TIME_PATTERN.match("11:45 am ET")

      assert_equal 45, parse_et_time(match).min
    end

    def test_midnight_returns_zero_hour
      match = ET_TIME_PATTERN.match("12:00 am ET")

      assert_equal 0, parse_et_time(match).hour
    end

    def test_noon_returns_twelve_hour
      match = ET_TIME_PATTERN.match("12:00 pm ET")

      assert_equal 12, parse_et_time(match).hour
    end

    def test_handles_uppercase_pm
      match = ET_TIME_PATTERN.match("7:30 PM ET")

      assert_equal 19, parse_et_time(match).hour
    end

    def test_handles_uppercase_am
      match = ET_TIME_PATTERN.match("11:30 AM ET")

      assert_equal 11, parse_et_time(match).hour
    end

    def test_ten_pm_returns_twenty_two
      match = ET_TIME_PATTERN.match("10:30 pm ET")

      assert_equal 22, parse_et_time(match).hour
    end

    def test_converts_minute_to_integer
      match = ET_TIME_PATTERN.match("7:05 pm ET")

      assert_equal 5, parse_et_time(match).min
    end

    def test_uses_first_capture_group_for_hour
      match = ET_TIME_PATTERN.match("9:15 pm ET")

      assert_equal "9", match[1]
      assert_equal 21, parse_et_time(match).hour
    end

    def test_uses_second_capture_group_for_minute
      match = ET_TIME_PATTERN.match("9:15 pm ET")

      assert_equal "15", match[2]
      assert_equal 15, parse_et_time(match).min
    end

    def test_uses_third_capture_group_for_period
      match = ET_TIME_PATTERN.match("9:15 PM ET")

      assert_equal "PM", match[3]
      assert_equal 21, parse_et_time(match).hour
    end

    def test_minute_is_converted_to_integer_not_string
      match = ET_TIME_PATTERN.match("7:05 pm ET")

      # Mock build_et_time to verify it receives an Integer minute, not a String
      called_with_minute = nil
      define_singleton_method(:build_et_time) do |hour, minute|
        called_with_minute = minute
        Time.new(2024, 1, 1, hour, minute, 0, "-05:00")
      end

      parse_et_time(match)

      assert_instance_of Integer, called_with_minute
      assert_equal 5, called_with_minute
    end

    def test_nil_minute_defaults_to_zero
      # This kills mutations that change || 0 to || 1, || -1, etc.
      match = MockMatchData.new(hour: "7", minute: nil, period: "pm")

      result = parse_et_time(match)

      assert_equal 0, result.min
    end

    def test_nil_period_defaults_to_am
      # This kills mutations that remove || "am" or change to || nil
      match = MockMatchData.new(hour: "7", minute: "30", period: nil)

      result = parse_et_time(match)

      # 7am should be hour 7, not 19 (pm)
      assert_equal 7, result.hour
    end

    def test_nil_hour_defaults_to_zero
      # This kills mutations that change the hour fallback
      match = MockMatchData.new(hour: nil, minute: "30", period: "am")

      result = parse_et_time(match)

      assert_equal 0, result.hour
    end

    def test_minute_fallback_is_exactly_zero
      # Verify the fallback is 0, not 1 or -1
      match = MockMatchData.new(hour: "12", minute: nil, period: "pm")

      result = parse_et_time(match)

      # If fallback were 1 or -1, minute would be different
      assert_equal 0, result.min
      refute_equal 1, result.min
      refute_equal(-1, result.min)
    end

    def test_period_fallback_is_am_not_nil
      # Verify the fallback is "am", producing morning hour
      match = MockMatchData.new(hour: "10", minute: "00", period: nil)

      result = parse_et_time(match)

      # If period fallback were nil, downcase would fail or hour would be wrong
      assert_equal 10, result.hour
    end
  end
end
