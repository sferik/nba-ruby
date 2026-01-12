require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffSummaryPlayerKeysTest < Minitest::Test
    cover TeamPlayerOnOffSummary

    def test_handles_missing_group_set_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("GROUP_SET").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.group_set
    end

    def test_handles_missing_team_id_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("TEAM_ID").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.team_id
    end

    def test_handles_missing_team_abbreviation_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("TEAM_ABBREVIATION").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.team_abbreviation
    end

    def test_handles_missing_team_name_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("TEAM_NAME").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.team_name
    end

    def test_handles_missing_vs_player_id_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("VS_PLAYER_ID").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.vs_player_id
    end

    def test_handles_missing_vs_player_name_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("VS_PLAYER_NAME").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.vs_player_name
    end

    def test_handles_missing_court_status_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("COURT_STATUS").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.court_status
    end

    def test_handles_missing_gp_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("GP").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.gp
    end

    def test_handles_missing_min_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("MIN").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.min
    end

    def test_handles_missing_plus_minus_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("PLUS_MINUS").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.plus_minus
    end

    def test_handles_missing_off_rating_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("OFF_RATING").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.off_rating
    end

    def test_handles_missing_def_rating_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("DEF_RATING").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.def_rating
    end

    def test_handles_missing_net_rating_key
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response_missing_key("NET_RATING").to_json)
      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744).first

      assert_nil result.net_rating
    end

    private

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "PlayersOnCourtTeamPlayerOnOffSummary", headers: hdrs, rowSet: [rw]}]}
    end

    def headers
      %w[GROUP_SET TEAM_ID TEAM_ABBREVIATION TEAM_NAME VS_PLAYER_ID VS_PLAYER_NAME
        COURT_STATUS GP MIN PLUS_MINUS OFF_RATING DEF_RATING NET_RATING]
    end

    def row
      ["On", 1_610_612_744, "GSW", "Warriors", 201_566, "Russell Westbrook", "On",
        20, 48.0, 5.5, 115.2, 108.7, 6.5]
    end
  end
end
