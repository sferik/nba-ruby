require_relative "../test_helper"

module NBA
  class LeagueLineupVizShootingMappingTest < Minitest::Test
    cover LeagueLineupViz

    def test_maps_pct_fga_2pt
      stub_lineup_viz_request

      assert_in_delta 0.545, stat.pct_fga_2pt
    end

    def test_maps_pct_fga_3pt
      stub_lineup_viz_request

      assert_in_delta 0.455, stat.pct_fga_3pt
    end

    def test_maps_pct_pts_2pt_mr
      stub_lineup_viz_request

      assert_in_delta 0.125, stat.pct_pts_2pt_mr
    end

    def test_maps_pct_pts_fb
      stub_lineup_viz_request

      assert_in_delta 0.152, stat.pct_pts_fb
    end

    def test_maps_pct_pts_ft
      stub_lineup_viz_request

      assert_in_delta 0.185, stat.pct_pts_ft
    end

    def test_maps_pct_pts_paint
      stub_lineup_viz_request

      assert_in_delta 0.425, stat.pct_pts_paint
    end

    def test_maps_pct_ast_fgm
      stub_lineup_viz_request

      assert_in_delta 0.652, stat.pct_ast_fgm
    end

    def test_maps_pct_uast_fgm
      stub_lineup_viz_request

      assert_in_delta 0.348, stat.pct_uast_fgm
    end

    private

    def stat
      LeagueLineupViz.all(season: 2024).first
    end

    def stub_lineup_viz_request
      stub_request(:get, /leaguelineupviz/).to_return(body: lineup_viz_response.to_json)
    end

    def lineup_viz_response
      {resultSets: [{name: "LeagueLineupViz", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[GROUP_ID GROUP_NAME TEAM_ID TEAM_ABBREVIATION MIN OFF_RATING DEF_RATING NET_RATING
        PACE TS_PCT FTA_RATE TM_AST_PCT PCT_FGA_2PT PCT_FGA_3PT PCT_PTS_2PT_MR PCT_PTS_FB
        PCT_PTS_FT PCT_PTS_PAINT PCT_AST_FGM PCT_UAST_FGM OPP_FG3_PCT OPP_EFG_PCT OPP_FTA_RATE
        OPP_TOV_PCT]
    end

    def stat_row
      ["201939-203110", "S. Curry - K. Thompson", Team::GSW, "GSW", 245.5, 115.3, 108.5, 6.8,
        101.2, 0.612, 0.285, 0.652, 0.545, 0.455, 0.125, 0.152, 0.185, 0.425, 0.652, 0.348,
        0.352, 0.512, 0.275, 0.132]
    end
  end
end
