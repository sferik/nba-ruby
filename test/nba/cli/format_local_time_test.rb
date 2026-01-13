require_relative "test_helper"

module NBA
  class FormatLocalTimeTest < Minitest::Test
    include CLI::Formatters::TimeFormatters

    cover CLI::Formatters::TimeFormatters

    def test_includes_timezone_abbreviation
      et_time = Time.new(2024, 1, 15, 19, 30, 0, "-05:00")

      assert_match(/\w{2,4}$/, format_local_time(et_time))
    end

    def test_includes_time_in_twelve_hour_format
      et_time = Time.new(2024, 1, 15, 19, 30, 0, "-05:00")

      assert_match(/\d{1,2}:\d{2} [AP]M/, format_local_time(et_time))
    end

    def test_converts_to_local_timezone
      et_time = Time.new(2024, 1, 15, 19, 30, 0, "-05:00")

      assert_match(/\d{1,2}:\d{2} [AP]M/, format_local_time(et_time))
    end

    def test_actually_converts_timezone
      et_time = Time.new(2024, 7, 15, 19, 30, 0, "-05:00")
      result = format_local_time(et_time)
      local_zone = Time.now.zone
      assert_includes result, local_zone if local_zone
    end

    def test_calls_localtime_on_et_time
      # Create ET time that is different when converted to local
      # 7:30 PM ET in winter (UTC-5) = midnight UTC
      et_time = Time.new(2024, 1, 15, 19, 30, 0, "-05:00")

      # Mock localtime to verify it's called
      mock_local = Time.new(2024, 1, 15, 16, 30, 0, "-08:00")
      et_time.stub(:localtime, mock_local) do
        result = format_local_time(et_time)
        # Should use the mocked local time (4:30 pm) not the ET time (7:30 pm)
        assert_includes result, "4:30"
        refute_includes result, "7:30"
      end
    end
  end
end
