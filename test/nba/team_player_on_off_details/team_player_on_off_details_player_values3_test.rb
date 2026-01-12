require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffDetailsPlayerValues3Test < Minitest::Test
    cover TeamPlayerOnOffDetails

    def setup
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response.to_json)
      @result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first
    end

    def test_extracts_gp_rank
      assert_equal 1, @result.gp_rank
    end

    def test_extracts_w_rank
      assert_equal 2, @result.w_rank
    end

    def test_extracts_l_rank
      assert_equal 3, @result.l_rank
    end

    def test_extracts_w_pct_rank
      assert_equal 4, @result.w_pct_rank
    end

    def test_extracts_min_rank
      assert_equal 5, @result.min_rank
    end

    def test_extracts_fgm_rank
      assert_equal 6, @result.fgm_rank
    end

    def test_extracts_fga_rank
      assert_equal 7, @result.fga_rank
    end

    def test_extracts_fg_pct_rank
      assert_equal 8, @result.fg_pct_rank
    end

    def test_extracts_fg3m_rank
      assert_equal 9, @result.fg3m_rank
    end

    def test_extracts_fg3a_rank
      assert_equal 10, @result.fg3a_rank
    end

    def test_extracts_fg3_pct_rank
      assert_equal 11, @result.fg3_pct_rank
    end

    def test_extracts_ftm_rank
      assert_equal 12, @result.ftm_rank
    end

    private

    def response
      {resultSets: [{name: "PlayersOnCourtTeamPlayerOnOffDetails", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[GROUP_SET TEAM_ID TEAM_ABBREVIATION TEAM_NAME VS_PLAYER_ID VS_PLAYER_NAME
        COURT_STATUS GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA
        FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS GP_RANK
        W_RANK L_RANK W_PCT_RANK MIN_RANK FGM_RANK FGA_RANK FG_PCT_RANK FG3M_RANK
        FG3A_RANK FG3_PCT_RANK FTM_RANK FTA_RANK FT_PCT_RANK OREB_RANK DREB_RANK
        REB_RANK AST_RANK TOV_RANK STL_RANK BLK_RANK BLKA_RANK PF_RANK PFD_RANK
        PTS_RANK PLUS_MINUS_RANK]
    end

    def row
      ["On", 1_610_612_744, "GSW", "Warriors", 201_566, "Russell Westbrook", "On", 20,
        12, 8, 0.600, 48.0, 8.5, 18.2, 0.467, 3.2, 8.5, 0.376, 3.8, 4.6, 0.826, 2.1,
        7.8, 9.9, 6.2, 3.1, 1.8, 1.2, 0.9, 4.5, 4.2, 24.0, 5.5, 1, 2, 3, 4, 5, 6, 7,
        8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
    end
  end
end
