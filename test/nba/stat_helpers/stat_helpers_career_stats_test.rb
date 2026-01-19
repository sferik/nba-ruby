require_relative "../../test_helper"

module NBA
  class StatHelpersCareerStatsTest < Minitest::Test
    cover CareerStats

    def test_per_minute_works_with_float_minutes
      stats = CareerStats.new(min: 32.5, pts: 26.0)

      assert_in_delta 0.8, stats.per_minute(:pts)
    end

    def test_per36_works_with_float_minutes
      stats = CareerStats.new(min: 32.5, pts: 26.0)

      assert_in_delta 28.8, stats.per36(:pts)
    end

    def test_per40_works_with_float_minutes
      stats = CareerStats.new(min: 32.5, pts: 26.0)

      assert_in_delta 32.0, stats.per40(:pts)
    end

    def test_per36_returns_nil_when_minutes_is_zero
      stats = CareerStats.new(min: 0.0, pts: 10.0)

      assert_nil stats.per36(:pts)
    end

    def test_per36_works_with_all_stat_types
      stats = CareerStats.new(min: 36.0, ast: 6.0, reb: 5.0, stl: 1.5)

      assert_in_delta 6.0, stats.per36(:ast)
      assert_in_delta 5.0, stats.per36(:reb)
      assert_in_delta 1.5, stats.per36(:stl)
    end
  end
end
