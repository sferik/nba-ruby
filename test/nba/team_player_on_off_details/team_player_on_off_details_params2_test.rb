require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffDetailsParams2Test < Minitest::Test
    cover TeamPlayerOnOffDetails

    def test_overall_uses_overall_result_set
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: overall_response.to_json)
      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_equal "Overall", result.first.group_set
    end

    def test_players_on_uses_players_on_result_set
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: players_on_response.to_json)
      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744)

      assert_equal "On", result.first.court_status
    end

    def test_players_off_uses_players_off_result_set
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: players_off_response.to_json)
      result = TeamPlayerOnOffDetails.players_off_court(team: 1_610_612_744)

      assert_equal "Off", result.first.court_status
    end

    private

    def overall_response
      hdrs = %w[GROUP_SET GROUP_VALUE TEAM_ID TEAM_ABBREVIATION TEAM_NAME GP W L]
      row = ["Overall", "On Court", 1_610_612_744, "GSW", "Warriors", 82, 46, 36]
      {resultSets: [{name: "OverallTeamPlayerOnOffDetails", headers: hdrs, rowSet: [row]}]}
    end

    def player_headers
      %w[GROUP_SET TEAM_ID TEAM_ABBREVIATION TEAM_NAME VS_PLAYER_ID VS_PLAYER_NAME
        COURT_STATUS GP W L]
    end

    def players_on_response
      row = ["On", 1_610_612_744, "GSW", "Warriors", 201_566, "Russell Westbrook", "On", 20, 12, 8]
      {resultSets: [{name: "PlayersOnCourtTeamPlayerOnOffDetails", headers: player_headers, rowSet: [row]}]}
    end

    def players_off_response
      row = ["Off", 1_610_612_744, "GSW", "Warriors", 201_566, "Russell Westbrook", "Off", 62, 34, 28]
      {resultSets: [{name: "PlayersOffCourtTeamPlayerOnOffDetails", headers: player_headers, rowSet: [row]}]}
    end
  end
end
