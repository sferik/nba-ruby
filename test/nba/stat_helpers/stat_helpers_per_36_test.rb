require_relative "../../test_helper"

module NBA
  class StatHelpersPer36Test < Minitest::Test
    cover GameLog

    def test_per36_normalizes_stat_to_thirty_six_minutes
      log = GameLog.new(min: 30, pts: 25)

      assert_in_delta 30.0, log.per36(:pts)
    end

    def test_per36_returns_same_value_when_minutes_is_thirty_six
      log = GameLog.new(min: 36, pts: 20)

      assert_in_delta 20.0, log.per36(:pts)
    end

    def test_per36_returns_nil_when_minutes_is_zero
      log = GameLog.new(min: 0, pts: 10)

      assert_nil log.per36(:pts)
    end

    def test_per36_returns_nil_when_minutes_is_nil
      log = GameLog.new(min: nil, pts: 10)

      assert_nil log.per36(:pts)
    end

    def test_per36_returns_nil_when_stat_is_nil
      log = GameLog.new(min: 30, pts: nil)

      assert_nil log.per36(:pts)
    end

    def test_per36_works_with_rebounds
      log = GameLog.new(min: 24, reb: 8)

      assert_in_delta 12.0, log.per36(:reb)
    end

    def test_per36_works_with_assists
      log = GameLog.new(min: 18, ast: 6)

      assert_in_delta 12.0, log.per36(:ast)
    end
  end
end
