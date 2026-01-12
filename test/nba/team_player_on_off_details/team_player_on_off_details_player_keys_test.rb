require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffDetailsPlayerKeysTest < Minitest::Test
    cover TeamPlayerOnOffDetails

    def test_handles_missing_group_set_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("GROUP_SET").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.group_set
    end

    def test_handles_missing_team_id_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("TEAM_ID").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.team_id
    end

    def test_handles_missing_team_abbreviation_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("TEAM_ABBREVIATION").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.team_abbreviation
    end

    def test_handles_missing_team_name_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("TEAM_NAME").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.team_name
    end

    def test_handles_missing_vs_player_id_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("VS_PLAYER_ID").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.vs_player_id
    end

    def test_handles_missing_vs_player_name_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("VS_PLAYER_NAME").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.vs_player_name
    end

    def test_handles_missing_court_status_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("COURT_STATUS").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.court_status
    end

    def test_handles_missing_gp_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("GP").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.gp
    end

    def test_handles_missing_w_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("W").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.w
    end

    def test_handles_missing_l_key
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response_missing_key("L").to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744).first

      assert_nil result.l
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
