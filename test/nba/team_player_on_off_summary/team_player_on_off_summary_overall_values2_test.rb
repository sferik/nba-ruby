require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffSummaryOverallValues2Test < Minitest::Test
    cover TeamPlayerOnOffSummary

    def setup
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response.to_json)
      @result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744).first
    end

    def test_extracts_ast
      assert_in_delta 27.5, @result.ast
    end

    def test_extracts_tov
      assert_in_delta 14.1, @result.tov
    end

    def test_extracts_stl
      assert_in_delta 7.6, @result.stl
    end

    def test_extracts_blk
      assert_in_delta 4.8, @result.blk
    end

    def test_extracts_blka
      assert_in_delta 4.2, @result.blka
    end

    def test_extracts_pf
      assert_in_delta 20.1, @result.pf
    end

    def test_extracts_pfd
      assert_in_delta 18.9, @result.pfd
    end

    def test_extracts_pts
      assert_in_delta 111.8, @result.pts
    end

    def test_extracts_plus_minus
      assert_in_delta 2.5, @result.plus_minus
    end

    def test_extracts_gp_rank
      assert_equal 1, @result.gp_rank
    end

    def test_extracts_w_rank
      assert_equal 5, @result.w_rank
    end

    def test_extracts_l_rank
      assert_equal 8, @result.l_rank
    end

    def test_extracts_w_pct_rank
      assert_equal 6, @result.w_pct_rank
    end

    def test_extracts_min_rank
      assert_equal 15, @result.min_rank
    end

    def test_extracts_fgm_rank
      assert_equal 10, @result.fgm_rank
    end

    def test_extracts_fga_rank
      assert_equal 12, @result.fga_rank
    end

    def test_extracts_fg_pct_rank
      assert_equal 8, @result.fg_pct_rank
    end

    def test_extracts_fg3m_rank
      assert_equal 3, @result.fg3m_rank
    end

    def test_extracts_fg3a_rank
      assert_equal 5, @result.fg3a_rank
    end

    def test_extracts_fg3_pct_rank
      assert_equal 7, @result.fg3_pct_rank
    end

    def test_extracts_ftm_rank
      assert_equal 14, @result.ftm_rank
    end

    def test_extracts_fta_rank
      assert_equal 16, @result.fta_rank
    end

    def test_extracts_ft_pct_rank
      assert_equal 9, @result.ft_pct_rank
    end

    private

    def response
      {resultSets: [{name: "OverallTeamPlayerOnOffSummary", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[GROUP_SET GROUP_VALUE TEAM_ID TEAM_ABBREVIATION TEAM_NAME GP W L W_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL
        BLK BLKA PF PFD PTS PLUS_MINUS GP_RANK W_RANK L_RANK W_PCT_RANK MIN_RANK
        FGM_RANK FGA_RANK FG_PCT_RANK FG3M_RANK FG3A_RANK FG3_PCT_RANK FTM_RANK
        FTA_RANK FT_PCT_RANK OREB_RANK DREB_RANK REB_RANK AST_RANK TOV_RANK
        STL_RANK BLK_RANK BLKA_RANK PF_RANK PFD_RANK PTS_RANK PLUS_MINUS_RANK]
    end

    def row
      ["Overall", "On Court", 1_610_612_744, "GSW", "Warriors", 82, 46, 36, 0.561, 240.0,
        39.6, 87.8, 0.451, 14.8, 40.2, 0.368, 17.8, 22.1, 0.805, 9.1, 34.8, 43.9,
        27.5, 14.1, 7.6, 4.8, 4.2, 20.1, 18.9, 111.8, 2.5, 1, 5, 8, 6, 15, 10, 12,
        8, 3, 5, 7, 14, 16, 9, 20, 11, 13, 4, 18, 7, 19, 22, 25, 17, 2, 6]
    end
  end
end
