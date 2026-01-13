require_relative "test_helper"

module NBA
  class ConvertTo24hTest < Minitest::Test
    include CLI::Formatters::TimeFormatters

    cover CLI::Formatters::TimeFormatters

    def test_am_hour_returns_same_hour
      assert_equal 11, convert_to_24h(11, "am")
    end

    def test_one_am_returns_one
      assert_equal 1, convert_to_24h(1, "am")
    end

    def test_midnight_returns_zero
      assert_equal 0, convert_to_24h(12, "am")
    end

    def test_pm_hour_adds_twelve
      assert_equal 13, convert_to_24h(1, "pm")
    end

    def test_seven_pm_returns_nineteen
      assert_equal 19, convert_to_24h(7, "pm")
    end

    def test_eleven_pm_returns_twenty_three
      assert_equal 23, convert_to_24h(11, "pm")
    end

    def test_noon_returns_twelve
      assert_equal 12, convert_to_24h(12, "pm")
    end
  end
end
