require_relative "../test_helper"

module NBA
  class BoxScoreV3HelpersStatsTest < Minitest::Test
    cover BoxScoreV3Helpers

    def test_shooting_stats_parses_field_goals
      result = BoxScoreV3Helpers.shooting_stats(complete_shooting_stats)

      assert_equal 10, result[:fgm]
      assert_equal 20, result[:fga]
      assert_in_delta 0.5, result[:fg_pct]
    end

    def test_shooting_stats_parses_three_pointers
      result = BoxScoreV3Helpers.shooting_stats(complete_shooting_stats)

      assert_equal 6, result[:fg3m]
      assert_equal 12, result[:fg3a]
      assert_in_delta 0.5, result[:fg3_pct]
    end

    def complete_shooting_stats
      {"fieldGoalsMade" => 10, "fieldGoalsAttempted" => 20, "fieldGoalsPercentage" => 0.5,
       "threePointersMade" => 6, "threePointersAttempted" => 12, "threePointersPercentage" => 0.5,
       "freeThrowsMade" => 5, "freeThrowsAttempted" => 6, "freeThrowsPercentage" => 0.833}
    end

    def test_shooting_stats_parses_free_throws
      stats = {"freeThrowsMade" => 5, "freeThrowsAttempted" => 6,
               "freeThrowsPercentage" => 0.833}

      result = BoxScoreV3Helpers.shooting_stats(stats)

      assert_in_delta 0.833, result[:ft_pct]
      assert_equal 5, result[:ftm]
      assert_equal 6, result[:fta]
    end

    def test_field_goal_stats_with_missing_keys
      result = BoxScoreV3Helpers.field_goal_stats({})

      assert_nil result[:fgm]
      assert_nil result[:fga]
      assert_nil result[:fg_pct]
    end

    def test_field_goal_stats_three_pointers_with_missing_keys
      result = BoxScoreV3Helpers.field_goal_stats({})

      assert_nil result[:fg3m]
      assert_nil result[:fg3a]
      assert_nil result[:fg3_pct]
    end

    def test_free_throw_stats_with_missing_keys
      result = BoxScoreV3Helpers.free_throw_stats({})

      assert_nil result[:ftm]
      assert_nil result[:fta]
      assert_nil result[:ft_pct]
    end

    def test_counting_stats_with_all_keys
      stats = {"reboundsOffensive" => 2, "reboundsDefensive" => 8,
               "reboundsTotal" => 10, "assists" => 5, "steals" => 2,
               "blocks" => 1, "turnovers" => 3, "foulsPersonal" => 2,
               "points" => 25, "plusMinusPoints" => 10}

      result = BoxScoreV3Helpers.counting_stats(stats)

      assert_equal 2, result[:oreb]
      assert_equal 8, result[:dreb]
      assert_equal 10, result[:reb]
      assert_equal 5, result[:ast]
      assert_equal 2, result[:stl]
    end

    def test_counting_stats_parses_remaining_stats
      stats = {"blocks" => 1, "turnovers" => 3, "foulsPersonal" => 2,
               "points" => 25, "plusMinusPoints" => 10}

      result = BoxScoreV3Helpers.counting_stats(stats)

      assert_equal 1, result[:blk]
      assert_equal 3, result[:tov]
      assert_equal 2, result[:pf]
      assert_equal 25, result[:pts]
      assert_equal 10, result[:plus_minus]
    end

    def test_rebound_stats_with_missing_keys
      result = BoxScoreV3Helpers.rebound_stats({})

      assert_nil result[:oreb]
      assert_nil result[:dreb]
      assert_nil result[:reb]
      assert_nil result[:ast]
    end

    def test_other_counting_stats_with_missing_keys
      result = BoxScoreV3Helpers.other_counting_stats({})

      assert_nil result[:stl]
      assert_nil result[:blk]
      assert_nil result[:tov]
      assert_nil result[:pf]
      assert_nil result[:pts]
    end
  end
end
