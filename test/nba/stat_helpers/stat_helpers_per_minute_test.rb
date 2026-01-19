require_relative "../../test_helper"

module NBA
  class StatHelpersPerMinuteTest < Minitest::Test
    cover GameLog

    def test_per_minute_returns_stat_divided_by_minutes
      log = GameLog.new(min: 36, pts: 36)

      assert_in_delta 1.0, log.per_minute(:pts)
    end

    def test_per_minute_returns_float
      log = GameLog.new(min: 30, pts: 25)

      assert_in_delta 0.833, log.per_minute(:pts), 0.001
    end

    def test_per_minute_returns_nil_when_minutes_is_zero
      log = GameLog.new(min: 0, pts: 10)

      assert_nil log.per_minute(:pts)
    end

    def test_per_minute_returns_nil_when_minutes_is_nil
      log = GameLog.new(min: nil, pts: 10)

      assert_nil log.per_minute(:pts)
    end

    def test_per_minute_returns_nil_when_stat_is_nil
      log = GameLog.new(min: 30, pts: nil)

      assert_nil log.per_minute(:pts)
    end

    def test_per_minute_works_with_float_stat_values
      log = GameLog.new(min: 30, pts: 15)

      assert_in_delta 0.5, log.per_minute(:pts)
    end
  end
end
