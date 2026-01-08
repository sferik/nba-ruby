require_relative "../test_helper"

module NBA
  class TeamPlayerOnOffDetailsPlayerRankKeys2Test < Minitest::Test
    cover TeamPlayerOnOffDetails

    def test_handles_missing_fg3_pct_rank_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("FG3_PCT_RANK").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.fg3_pct_rank
    end

    def test_handles_missing_ftm_rank_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("FTM_RANK").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.ftm_rank
    end

    def test_handles_missing_fta_rank_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("FTA_RANK").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.fta_rank
    end

    def test_handles_missing_ft_pct_rank_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("FT_PCT_RANK").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.ft_pct_rank
    end

    def test_handles_missing_oreb_rank_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("OREB_RANK").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.oreb_rank
    end

    def test_handles_missing_dreb_rank_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("DREB_RANK").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.dreb_rank
    end

    def test_handles_missing_reb_rank_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("REB_RANK").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.reb_rank
    end

    def test_handles_missing_ast_rank_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("AST_RANK").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.ast_rank
    end

    def test_handles_missing_tov_rank_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("TOV_RANK").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.tov_rank
    end

    def test_handles_missing_stl_rank_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("STL_RANK").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.stl_rank
    end

    private

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "PlayersOnCourtTeamPlayerOnOffDetails", headers: hdrs, rowSet: [rw]}]}
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
