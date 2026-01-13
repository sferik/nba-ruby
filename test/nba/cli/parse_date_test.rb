require_relative "test_helper"

module NBA
  class ParseDateTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    # Provide Thor's say method for error messages (discards output)
    def say(_message) = nil

    def test_returns_eastern_time_for_nil
      assert_equal eastern_time_date, parse_date(nil)
    rescue SystemExit
      flunk "parse_date(nil) raised SystemExit"
    end

    def test_returns_eastern_time_for_today
      assert_equal eastern_time_date, parse_date("today")
    rescue SystemExit
      flunk "parse_date('today') raised SystemExit"
    end

    def test_today_returns_different_date_than_yesterday
      # This kills mutations that replace "today" check with false/nil
      refute_equal parse_date("yesterday"), parse_date("today")
    rescue SystemExit
      flunk "parse_date raised SystemExit comparing today/yesterday"
    end

    def test_today_returns_different_date_than_tomorrow
      # This kills mutations that replace "today" check with false/nil
      refute_equal parse_date("tomorrow"), parse_date("today")
    rescue SystemExit
      flunk "parse_date raised SystemExit comparing today/tomorrow"
    end

    def test_returns_yesterday_for_yesterday
      assert_equal eastern_time_date - 1, parse_date("yesterday")
    rescue SystemExit
      flunk "parse_date('yesterday') raised SystemExit"
    end

    def test_yesterday_differs_from_today_by_one_day
      # This kills mutations that replace yesterday branch with nil
      assert_equal(-1, parse_date("yesterday") - parse_date("today"))
    rescue SystemExit
      flunk "parse_date raised SystemExit for yesterday calculation"
    end

    def test_returns_tomorrow_for_tomorrow
      assert_equal eastern_time_date + 1, parse_date("tomorrow")
    rescue SystemExit
      flunk "parse_date('tomorrow') raised SystemExit"
    end

    def test_tomorrow_differs_from_today_by_one_day
      # This kills mutations that replace tomorrow branch with nil
      assert_equal 1, parse_date("tomorrow") - parse_date("today")
    rescue SystemExit
      flunk "parse_date raised SystemExit for tomorrow calculation"
    end

    def test_parses_yyyymmdd_format
      result = parse_date("20240115")

      assert_equal Date.new(2024, 1, 15), result
    rescue SystemExit
      flunk "parse_date raised SystemExit for valid date"
    end

    def test_string_parses_valid_date
      result = parse_date_string("20240315")

      assert_equal Date.new(2024, 3, 15), result
    rescue SystemExit
      flunk "parse_date_string raised SystemExit for valid date"
    end

    def test_string_raises_system_exit_for_invalid_date
      assert_raises(SystemExit) { parse_date_string("invalid") }
    end

    def test_parse_date_today_does_not_raise
      # This test verifies that "today" is handled by parse_date,
      # not passed to parse_date_string (which would raise SystemExit)
      result = parse_date("today")

      assert_kind_of Date, result
    rescue SystemExit
      flunk "parse_date('today') raised SystemExit"
    end

    def test_parse_date_yesterday_does_not_raise
      # This test verifies that "yesterday" is handled by parse_date,
      # not passed to parse_date_string (which would raise SystemExit)
      result = parse_date("yesterday")

      assert_kind_of Date, result
    rescue SystemExit
      flunk "parse_date('yesterday') raised SystemExit"
    end

    def test_parse_date_tomorrow_does_not_raise
      # This test verifies that "tomorrow" is handled by parse_date,
      # not passed to parse_date_string (which would raise SystemExit)
      result = parse_date("tomorrow")

      assert_kind_of Date, result
    rescue SystemExit
      flunk "parse_date('tomorrow') raised SystemExit"
    end
  end
end
