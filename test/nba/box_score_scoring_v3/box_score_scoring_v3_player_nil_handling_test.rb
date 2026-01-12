require_relative "../../test_helper"
require_relative "../box_score/box_score_v3_test_helpers"

module NBA
  class BoxScoreScoringV3PlayerNilHandlingTest < Minitest::Test
    include BoxScoreV3TestHelpers

    cover BoxScoreScoringV3

    def test_player_stats_returns_nil_for_missing_basic_stat_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.min
      assert_nil stat.pct_fga_2pt
      assert_nil stat.pct_fga_3pt
    end

    def test_player_stats_returns_nil_for_missing_points_stat_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.pct_pts_2pt
      assert_nil stat.pct_pts_2pt_mr
      assert_nil stat.pct_pts_3pt
    end

    def test_player_stats_returns_nil_for_missing_point_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.pct_pts_fb
      assert_nil stat.pct_pts_ft
      assert_nil stat.pct_pts_off_tov
      assert_nil stat.pct_pts_paint
    end

    def test_player_stats_returns_nil_for_missing_2pt_assist_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.pct_ast_2pm
      assert_nil stat.pct_uast_2pm
    end

    def test_player_stats_returns_nil_for_missing_3pt_assist_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.pct_ast_3pm
      assert_nil stat.pct_uast_3pm
    end

    def test_player_stats_returns_nil_for_missing_fgm_assist_keys
      stat = player_stat_with_empty_stats

      assert_nil stat.pct_ast_fgm
      assert_nil stat.pct_uast_fgm
    end

    def test_player_stats_returns_nil_for_missing_player_keys
      stat = player_stat_with_minimal_data

      assert_nil stat.team_id
      assert_nil stat.team_abbreviation
      assert_nil stat.team_city
      assert_nil stat.player_id
      assert_equal "", stat.player_name
    end

    def test_player_stats_handles_missing_statistics_key
      stub_player_response({personId: 201_939, firstName: "Stephen", familyName: "Curry"})
      stat = BoxScoreScoringV3.player_stats(game: "0022400001").first

      assert_nil stat.min
      assert_nil stat.pct_fga_2pt
    end

    private

    def player_stat_with_empty_stats
      stub_player_response(
        {personId: 201_939, firstName: "Stephen",
         familyName: "Curry", teamId: Team::GSW, statistics: {}}
      )
      BoxScoreScoringV3.player_stats(game: "0022400001").first
    end

    def player_stat_with_minimal_data
      stub_player_response({statistics: {minutes: "32:45"}})
      BoxScoreScoringV3.player_stats(game: "0022400001").first
    end
  end
end
