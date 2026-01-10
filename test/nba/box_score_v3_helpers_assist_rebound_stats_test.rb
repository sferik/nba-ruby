require_relative "../test_helper"

module NBA
  class BoxScoreV3HelpersAssistReboundStatsTest < Minitest::Test
    cover BoxScoreV3Helpers

    def test_parses_ast_pct
      stats = {"assistPercentage" => 0.25}

      result = BoxScoreV3Helpers.advanced_efficiency_stats(stats)

      assert_in_delta 0.25, result[:ast_pct]
    end

    def test_parses_ast_tov
      stats = {"assistToTurnover" => 2.5}

      result = BoxScoreV3Helpers.advanced_efficiency_stats(stats)

      assert_in_delta 2.5, result[:ast_tov]
    end

    def test_parses_ast_ratio
      stats = {"assistRatio" => 0.18}

      result = BoxScoreV3Helpers.advanced_efficiency_stats(stats)

      assert_in_delta 0.18, result[:ast_ratio]
    end

    def test_parses_oreb_pct
      stats = {"reboundsOffensivePercentage" => 0.05}

      result = BoxScoreV3Helpers.advanced_efficiency_stats(stats)

      assert_in_delta 0.05, result[:oreb_pct]
    end

    def test_parses_dreb_pct
      stats = {"reboundsDefensivePercentage" => 0.20}

      result = BoxScoreV3Helpers.advanced_efficiency_stats(stats)

      assert_in_delta 0.20, result[:dreb_pct]
    end

    def test_missing_ast_pct_returns_nil
      result = BoxScoreV3Helpers.advanced_efficiency_stats({})

      assert_nil result[:ast_pct]
    end

    def test_missing_ast_tov_returns_nil
      result = BoxScoreV3Helpers.advanced_efficiency_stats({})

      assert_nil result[:ast_tov]
    end

    def test_missing_ast_ratio_returns_nil
      result = BoxScoreV3Helpers.advanced_efficiency_stats({})

      assert_nil result[:ast_ratio]
    end

    def test_missing_oreb_pct_returns_nil
      result = BoxScoreV3Helpers.advanced_efficiency_stats({})

      assert_nil result[:oreb_pct]
    end

    def test_missing_dreb_pct_returns_nil
      result = BoxScoreV3Helpers.advanced_efficiency_stats({})

      assert_nil result[:dreb_pct]
    end
  end
end
