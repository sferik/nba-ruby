require_relative "../../test_helper"

module NBA
  class BoxScoreScoringPlayerStatsAttributeMappingTest < Minitest::Test
    cover BoxScoreScoring

    def test_maps_game_and_team_attributes
      stub_box_score_request

      stat = BoxScoreScoring.player_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
    end

    def test_maps_player_identity_attributes
      stub_box_score_request

      stat = BoxScoreScoring.player_stats(game: "0022400001").first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal "G", stat.start_position
      assert_equal "", stat.comment
      assert_equal "34:22", stat.min
    end

    def test_maps_field_goal_attempt_percentages
      stub_box_score_request

      stat = BoxScoreScoring.player_stats(game: "0022400001").first

      assert_in_delta 0.4, stat.pct_fga_2pt
      assert_in_delta 0.6, stat.pct_fga_3pt
    end

    def test_maps_points_source_percentages
      stub_box_score_request

      stat = BoxScoreScoring.player_stats(game: "0022400001").first

      assert_in_delta 0.2, stat.pct_pts_2pt
      assert_in_delta 0.1, stat.pct_pts_2pt_mr
      assert_in_delta 0.5, stat.pct_pts_3pt
      assert_in_delta 0.15, stat.pct_pts_fb
      assert_in_delta 0.1, stat.pct_pts_ft
    end

    def test_maps_points_context_percentages
      stub_box_score_request

      stat = BoxScoreScoring.player_stats(game: "0022400001").first

      assert_in_delta 0.05, stat.pct_pts_off_tov
      assert_in_delta 0.25, stat.pct_pts_paint
    end

    def test_maps_two_point_assist_attributes
      stub_box_score_request

      stat = BoxScoreScoring.player_stats(game: "0022400001").first

      assert_in_delta 0.3, stat.pct_ast_2pm
      assert_in_delta 0.7, stat.pct_uast_2pm
    end

    def test_maps_three_point_assist_attributes
      stub_box_score_request

      stat = BoxScoreScoring.player_stats(game: "0022400001").first

      assert_in_delta 0.5, stat.pct_ast_3pm
      assert_in_delta 0.5, stat.pct_uast_3pm
    end

    def test_maps_total_assist_attributes
      stub_box_score_request

      stat = BoxScoreScoring.player_stats(game: "0022400001").first

      assert_in_delta 0.4, stat.pct_ast_fgm
      assert_in_delta 0.6, stat.pct_uast_fgm
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscorescoringv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN PCT_FGA_2PT PCT_FGA_3PT PCT_PTS_2PT PCT_PTS_2PT_MR PCT_PTS_3PT PCT_PTS_FB PCT_PTS_FT
        PCT_PTS_OFF_TOV PCT_PTS_PAINT PCT_AST_2PM PCT_UAST_2PM PCT_AST_3PM PCT_UAST_3PM PCT_AST_FGM PCT_UAST_FGM]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 0.4, 0.6, 0.2, 0.1, 0.5, 0.15, 0.1, 0.05, 0.25, 0.3, 0.7, 0.5, 0.5, 0.4, 0.6]
    end
  end
end
