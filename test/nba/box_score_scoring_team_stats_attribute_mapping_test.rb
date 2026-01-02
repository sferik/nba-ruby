require_relative "../test_helper"

module NBA
  class BoxScoreScoringTeamStatsAttributeMappingTest < Minitest::Test
    cover BoxScoreScoring

    def test_maps_game_and_team_attributes
      stub_box_score_request

      stat = BoxScoreScoring.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
    end

    def test_maps_team_location_and_time_attributes
      stub_box_score_request

      stat = BoxScoreScoring.team_stats(game: "0022400001").first

      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
      assert_equal "240:00", stat.min
    end

    def test_maps_field_goal_attempt_percentages
      stub_box_score_request

      stat = BoxScoreScoring.team_stats(game: "0022400001").first

      assert_in_delta 0.45, stat.pct_fga_2pt
      assert_in_delta 0.55, stat.pct_fga_3pt
    end

    def test_maps_points_source_percentages
      stub_box_score_request

      stat = BoxScoreScoring.team_stats(game: "0022400001").first

      assert_in_delta 0.25, stat.pct_pts_2pt
      assert_in_delta 0.1, stat.pct_pts_2pt_mr
      assert_in_delta 0.45, stat.pct_pts_3pt
      assert_in_delta 0.12, stat.pct_pts_fb
      assert_in_delta 0.15, stat.pct_pts_ft
    end

    def test_maps_points_context_percentages
      stub_box_score_request

      stat = BoxScoreScoring.team_stats(game: "0022400001").first

      assert_in_delta 0.08, stat.pct_pts_off_tov
      assert_in_delta 0.30, stat.pct_pts_paint
    end

    def test_maps_two_point_assist_attributes
      stub_box_score_request

      stat = BoxScoreScoring.team_stats(game: "0022400001").first

      assert_in_delta 0.6, stat.pct_ast_2pm
      assert_in_delta 0.4, stat.pct_uast_2pm
    end

    def test_maps_three_point_assist_attributes
      stub_box_score_request

      stat = BoxScoreScoring.team_stats(game: "0022400001").first

      assert_in_delta 0.7, stat.pct_ast_3pm
      assert_in_delta 0.3, stat.pct_uast_3pm
    end

    def test_maps_total_assist_attributes
      stub_box_score_request

      stat = BoxScoreScoring.team_stats(game: "0022400001").first

      assert_in_delta 0.65, stat.pct_ast_fgm
      assert_in_delta 0.35, stat.pct_uast_fgm
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscorescoringv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN PCT_FGA_2PT PCT_FGA_3PT
        PCT_PTS_2PT PCT_PTS_2PT_MR PCT_PTS_3PT PCT_PTS_FB PCT_PTS_FT PCT_PTS_OFF_TOV PCT_PTS_PAINT
        PCT_AST_2PM PCT_UAST_2PM PCT_AST_3PM PCT_UAST_3PM PCT_AST_FGM PCT_UAST_FGM]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        0.45, 0.55, 0.25, 0.1, 0.45, 0.12, 0.15, 0.08, 0.30, 0.6, 0.4, 0.7, 0.3, 0.65, 0.35]
    end
  end
end
