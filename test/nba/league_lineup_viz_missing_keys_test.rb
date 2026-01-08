require_relative "../test_helper"

module NBA
  class LeagueLineupVizMissingKeysTest < Minitest::Test
    cover LeagueLineupViz

    def test_handles_missing_group_id
      assert_missing_key_returns_nil("GROUP_ID", 0, :group_id)
    end

    def test_handles_missing_group_name
      assert_missing_key_returns_nil("GROUP_NAME", 1, :group_name)
    end

    def test_handles_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 2, :team_id)
    end

    def test_handles_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 3, :team_abbreviation)
    end

    def test_handles_missing_min
      assert_missing_key_returns_nil("MIN", 4, :min)
    end

    def test_handles_missing_off_rating
      assert_missing_key_returns_nil("OFF_RATING", 5, :off_rating)
    end

    def test_handles_missing_def_rating
      assert_missing_key_returns_nil("DEF_RATING", 6, :def_rating)
    end

    def test_handles_missing_net_rating
      assert_missing_key_returns_nil("NET_RATING", 7, :net_rating)
    end

    def test_handles_missing_pace
      assert_missing_key_returns_nil("PACE", 8, :pace)
    end

    def test_handles_missing_ts_pct
      assert_missing_key_returns_nil("TS_PCT", 9, :ts_pct)
    end

    def test_handles_missing_fta_rate
      assert_missing_key_returns_nil("FTA_RATE", 10, :fta_rate)
    end

    def test_handles_missing_tm_ast_pct
      assert_missing_key_returns_nil("TM_AST_PCT", 11, :tm_ast_pct)
    end

    def test_handles_missing_pct_fga_2pt
      assert_missing_key_returns_nil("PCT_FGA_2PT", 12, :pct_fga_2pt)
    end

    def test_handles_missing_pct_fga_3pt
      assert_missing_key_returns_nil("PCT_FGA_3PT", 13, :pct_fga_3pt)
    end

    def test_handles_missing_pct_pts_2pt_mr
      assert_missing_key_returns_nil("PCT_PTS_2PT_MR", 14, :pct_pts_2pt_mr)
    end

    def test_handles_missing_pct_pts_fb
      assert_missing_key_returns_nil("PCT_PTS_FB", 15, :pct_pts_fb)
    end

    def test_handles_missing_pct_pts_ft
      assert_missing_key_returns_nil("PCT_PTS_FT", 16, :pct_pts_ft)
    end

    def test_handles_missing_pct_pts_paint
      assert_missing_key_returns_nil("PCT_PTS_PAINT", 17, :pct_pts_paint)
    end

    def test_handles_missing_pct_ast_fgm
      assert_missing_key_returns_nil("PCT_AST_FGM", 18, :pct_ast_fgm)
    end

    def test_handles_missing_pct_uast_fgm
      assert_missing_key_returns_nil("PCT_UAST_FGM", 19, :pct_uast_fgm)
    end

    def test_handles_missing_opp_fg3_pct
      assert_missing_key_returns_nil("OPP_FG3_PCT", 20, :opp_fg3_pct)
    end

    def test_handles_missing_opp_efg_pct
      assert_missing_key_returns_nil("OPP_EFG_PCT", 21, :opp_efg_pct)
    end

    def test_handles_missing_opp_fta_rate
      assert_missing_key_returns_nil("OPP_FTA_RATE", 22, :opp_fta_rate)
    end

    def test_handles_missing_opp_tov_pct
      assert_missing_key_returns_nil("OPP_TOV_PCT", 23, :opp_tov_pct)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueLineupViz", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguelineupviz/).to_return(body: response.to_json)

      stat = LeagueLineupViz.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
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
