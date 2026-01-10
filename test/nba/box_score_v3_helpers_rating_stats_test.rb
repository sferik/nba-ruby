require_relative "../test_helper"

module NBA
  class BoxScoreV3HelpersRatingStatsTest < Minitest::Test
    cover BoxScoreV3Helpers

    def test_parses_e_off_rating
      stats = {"estimatedOffensiveRating" => 115.0}

      result = BoxScoreV3Helpers.advanced_rating_stats(stats)

      assert_in_delta 115.0, result[:e_off_rating]
    end

    def test_parses_off_rating
      stats = {"offensiveRating" => 118.0}

      result = BoxScoreV3Helpers.advanced_rating_stats(stats)

      assert_in_delta 118.0, result[:off_rating]
    end

    def test_parses_e_def_rating
      stats = {"estimatedDefensiveRating" => 105.0}

      result = BoxScoreV3Helpers.advanced_rating_stats(stats)

      assert_in_delta 105.0, result[:e_def_rating]
    end

    def test_parses_def_rating
      stats = {"defensiveRating" => 108.0}

      result = BoxScoreV3Helpers.advanced_rating_stats(stats)

      assert_in_delta 108.0, result[:def_rating]
    end

    def test_parses_e_net_rating
      stats = {"estimatedNetRating" => 10.0}

      result = BoxScoreV3Helpers.advanced_rating_stats(stats)

      assert_in_delta 10.0, result[:e_net_rating]
    end

    def test_parses_net_rating
      stats = {"netRating" => 10.0}

      result = BoxScoreV3Helpers.advanced_rating_stats(stats)

      assert_in_delta 10.0, result[:net_rating]
    end

    def test_missing_e_off_rating_returns_nil
      result = BoxScoreV3Helpers.advanced_rating_stats({})

      assert_nil result[:e_off_rating]
    end

    def test_missing_off_rating_returns_nil
      result = BoxScoreV3Helpers.advanced_rating_stats({})

      assert_nil result[:off_rating]
    end

    def test_missing_e_def_rating_returns_nil
      result = BoxScoreV3Helpers.advanced_rating_stats({})

      assert_nil result[:e_def_rating]
    end

    def test_missing_def_rating_returns_nil
      result = BoxScoreV3Helpers.advanced_rating_stats({})

      assert_nil result[:def_rating]
    end

    def test_missing_e_net_rating_returns_nil
      result = BoxScoreV3Helpers.advanced_rating_stats({})

      assert_nil result[:e_net_rating]
    end

    def test_missing_net_rating_returns_nil
      result = BoxScoreV3Helpers.advanced_rating_stats({})

      assert_nil result[:net_rating]
    end
  end
end
