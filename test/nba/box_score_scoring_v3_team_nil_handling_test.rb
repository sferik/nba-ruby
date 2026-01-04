require_relative "../test_helper"
require_relative "box_score_v3_test_helpers"

module NBA
  class BoxScoreScoringV3TeamNilHandlingTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreScoringV3

    def test_team_stats_returns_nil_for_missing_basic_stat_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.min
      assert_nil stat.pct_fga_2pt
      assert_nil stat.pct_fga_3pt
    end

    def test_team_stats_returns_nil_for_missing_points_stat_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.pct_pts_2pt
      assert_nil stat.pct_pts_2pt_mr
      assert_nil stat.pct_pts_3pt
    end

    def test_team_stats_returns_nil_for_missing_point_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.pct_pts_fb
      assert_nil stat.pct_pts_ft
      assert_nil stat.pct_pts_off_tov
      assert_nil stat.pct_pts_paint
    end

    def test_team_stats_returns_nil_for_missing_2pt_assist_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.pct_ast_2pm
      assert_nil stat.pct_uast_2pm
    end

    def test_team_stats_returns_nil_for_missing_3pt_assist_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.pct_ast_3pm
      assert_nil stat.pct_uast_3pm
    end

    def test_team_stats_returns_nil_for_missing_fgm_assist_keys
      stat = team_stat_with_empty_stats

      assert_nil stat.pct_ast_fgm
      assert_nil stat.pct_uast_fgm
    end

    def test_team_stats_handles_missing_statistics_key
      stub_team_response({teamId: Team::GSW, teamName: "Warriors"})
      stat = BoxScoreScoringV3.team_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.pct_fga_2pt
    end

    def test_team_stats_returns_nil_for_missing_team_keys
      stat = team_stat_with_minimal_data

      assert_nil stat.team_id
      assert_nil stat.team_name
      assert_nil stat.team_abbreviation
      assert_nil stat.team_city
    end

    private

    def team_stat_with_empty_stats
      stub_team_response(
        {teamId: Team::GSW, teamName: "Warriors", statistics: {}}
      )
      BoxScoreScoringV3.team_stats(game: "0022400001").first
    end

    def team_stat_with_minimal_data
      stub_team_response({statistics: {minutes: "240:00"}})
      BoxScoreScoringV3.team_stats(game: "0022400001").first
    end
  end
end
