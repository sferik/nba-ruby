require_relative "../../test_helper"

module NBA
  class LeagueLineupVizOpponentMappingTest < Minitest::Test
    cover LeagueLineupViz

    def test_maps_opp_fg3_pct
      stub_lineup_viz_request

      assert_in_delta 0.352, stat.opp_fg3_pct
    end

    def test_maps_opp_efg_pct
      stub_lineup_viz_request

      assert_in_delta 0.512, stat.opp_efg_pct
    end

    def test_maps_opp_fta_rate
      stub_lineup_viz_request

      assert_in_delta 0.275, stat.opp_fta_rate
    end

    def test_maps_opp_tov_pct
      stub_lineup_viz_request

      assert_in_delta 0.132, stat.opp_tov_pct
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
