require_relative "../../test_helper"

module NBA
  class BoxScoreV3HelpersTempoStatsTest < Minitest::Test
    cover BoxScoreV3Helpers

    def test_parses_e_pace
      stats = {"estimatedPace" => 100.0}

      result = BoxScoreV3Helpers.advanced_tempo_stats(stats)

      assert_in_delta 100.0, result[:e_pace]
    end

    def test_parses_pace
      stats = {"pace" => 102.0}

      result = BoxScoreV3Helpers.advanced_tempo_stats(stats)

      assert_in_delta 102.0, result[:pace]
    end

    def test_parses_pace_per40
      stats = {"pacePer40" => 105.0}

      result = BoxScoreV3Helpers.advanced_tempo_stats(stats)

      assert_in_delta 105.0, result[:pace_per40]
    end

    def test_parses_poss
      stats = {"possessions" => 98.0}

      result = BoxScoreV3Helpers.advanced_tempo_stats(stats)

      assert_in_delta 98.0, result[:poss]
    end

    def test_missing_e_pace_returns_nil
      result = BoxScoreV3Helpers.advanced_tempo_stats({})

      assert_nil result[:e_pace]
    end

    def test_missing_pace_returns_nil
      result = BoxScoreV3Helpers.advanced_tempo_stats({})

      assert_nil result[:pace]
    end

    def test_missing_pace_per40_returns_nil
      result = BoxScoreV3Helpers.advanced_tempo_stats({})

      assert_nil result[:pace_per40]
    end

    def test_missing_poss_returns_nil
      result = BoxScoreV3Helpers.advanced_tempo_stats({})

      assert_nil result[:poss]
    end
  end
end
