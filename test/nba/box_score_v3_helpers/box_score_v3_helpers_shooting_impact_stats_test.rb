require_relative "../../test_helper"

module NBA
  class BoxScoreV3HelpersShootingImpactStatsTest < Minitest::Test
    cover BoxScoreV3Helpers

    def test_parses_reb_pct
      stats = {"reboundsPercentage" => 0.12}

      result = BoxScoreV3Helpers.advanced_efficiency_stats(stats)

      assert_in_delta 0.12, result[:reb_pct]
    end

    def test_parses_tov_pct
      stats = {"turnoverPercentage" => 0.10}

      result = BoxScoreV3Helpers.advanced_efficiency_stats(stats)

      assert_in_delta 0.10, result[:tov_pct]
    end

    def test_parses_efg_pct
      stats = {"effectiveFieldGoalPercentage" => 0.55}

      result = BoxScoreV3Helpers.advanced_efficiency_stats(stats)

      assert_in_delta 0.55, result[:efg_pct]
    end

    def test_parses_ts_pct
      stats = {"trueShootingPercentage" => 0.60}

      result = BoxScoreV3Helpers.advanced_efficiency_stats(stats)

      assert_in_delta 0.60, result[:ts_pct]
    end

    def test_parses_pie
      stats = {"playerImpactEstimate" => 0.15}

      result = BoxScoreV3Helpers.advanced_efficiency_stats(stats)

      assert_in_delta 0.15, result[:pie]
    end

    def test_missing_reb_pct_returns_nil
      result = BoxScoreV3Helpers.advanced_efficiency_stats({})

      assert_nil result[:reb_pct]
    end

    def test_missing_tov_pct_returns_nil
      result = BoxScoreV3Helpers.advanced_efficiency_stats({})

      assert_nil result[:tov_pct]
    end

    def test_missing_efg_pct_returns_nil
      result = BoxScoreV3Helpers.advanced_efficiency_stats({})

      assert_nil result[:efg_pct]
    end

    def test_missing_ts_pct_returns_nil
      result = BoxScoreV3Helpers.advanced_efficiency_stats({})

      assert_nil result[:ts_pct]
    end

    def test_missing_pie_returns_nil
      result = BoxScoreV3Helpers.advanced_efficiency_stats({})

      assert_nil result[:pie]
    end
  end
end
