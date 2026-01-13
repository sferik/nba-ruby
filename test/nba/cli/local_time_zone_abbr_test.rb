require_relative "test_helper"

module NBA
  class LocalTimeZoneAbbrTest < Minitest::Test
    include CLI::Formatters::TimeFormatters

    cover CLI::Formatters::TimeFormatters

    def test_returns_current_zone
      result = local_time_zone_abbr

      assert_kind_of String, result
      refute_empty result
    end

    def test_returns_et_when_zone_nil
      Time.stub(:now, Struct.new(:zone).new(nil)) do
        assert_equal "ET", local_time_zone_abbr
      end
    end
  end
end
