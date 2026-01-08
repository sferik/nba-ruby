require_relative "../test_helper"

module NBA
  class TeamPlayerOnOffDetailsPlayerValues2Test < Minitest::Test
    cover TeamPlayerOnOffDetails

    def setup
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response.to_json)
      @result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first
    end

    def test_extracts_ftm
      assert_in_delta 3.8, @result.ftm
    end

    def test_extracts_fta
      assert_in_delta 4.6, @result.fta
    end

    def test_extracts_ft_pct
      assert_in_delta 0.826, @result.ft_pct
    end

    def test_extracts_oreb
      assert_in_delta 2.1, @result.oreb
    end

    def test_extracts_dreb
      assert_in_delta 7.8, @result.dreb
    end

    def test_extracts_reb
      assert_in_delta 9.9, @result.reb
    end

    def test_extracts_ast
      assert_in_delta 6.2, @result.ast
    end

    def test_extracts_tov
      assert_in_delta 3.1, @result.tov
    end

    def test_extracts_stl
      assert_in_delta 1.8, @result.stl
    end

    def test_extracts_blk
      assert_in_delta 1.2, @result.blk
    end

    def test_extracts_blka
      assert_in_delta 0.9, @result.blka
    end

    def test_extracts_pf
      assert_in_delta 4.5, @result.pf
    end

    def test_extracts_pfd
      assert_in_delta 4.2, @result.pfd
    end

    def test_extracts_pts
      assert_in_delta 24.0, @result.pts
    end

    def test_extracts_plus_minus
      assert_in_delta 5.5, @result.plus_minus
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
