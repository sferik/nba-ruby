require_relative "../../test_helper"

module NBA
  class StatHelpersPer40Test < Minitest::Test
    cover GameLog

    def test_per40_normalizes_stat_to_forty_minutes
      log = GameLog.new(min: 20, pts: 15)

      assert_in_delta 30.0, log.per40(:pts)
    end

    def test_per40_returns_same_value_when_minutes_is_forty
      log = GameLog.new(min: 40, pts: 25)

      assert_in_delta 25.0, log.per40(:pts)
    end

    def test_per40_returns_nil_when_minutes_is_zero
      log = GameLog.new(min: 0, pts: 10)

      assert_nil log.per40(:pts)
    end

    def test_per40_returns_nil_when_minutes_is_nil
      log = GameLog.new(min: nil, pts: 10)

      assert_nil log.per40(:pts)
    end

    def test_per40_returns_nil_when_stat_is_nil
      log = GameLog.new(min: 30, pts: nil)

      assert_nil log.per40(:pts)
    end

    def test_per40_works_with_rebounds
      log = GameLog.new(min: 20, reb: 5)

      assert_in_delta 10.0, log.per40(:reb)
    end

    def test_per40_works_with_steals
      log = GameLog.new(min: 40, stl: 2)

      assert_in_delta 2.0, log.per40(:stl)
    end
  end
end
