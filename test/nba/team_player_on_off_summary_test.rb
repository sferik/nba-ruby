require_relative "../test_helper"

module NBA
  class TeamPlayerOnOffSummaryTest < Minitest::Test
    cover TeamPlayerOnOffSummary

    def test_overall_returns_collection
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: overall_response.to_json)

      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_overall_returns_overall_stat_objects
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: overall_response.to_json)

      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_kind_of TeamOnOffOverallStat, result.first
    end

    def test_players_on_court_returns_collection
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: players_on_response.to_json)

      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_players_on_court_returns_player_summary_objects
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: players_on_response.to_json)

      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744)

      assert_kind_of TeamOnOffPlayerSummary, result.first
    end

    def test_players_off_court_returns_collection
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: players_off_response.to_json)

      result = TeamPlayerOnOffSummary.players_off_court(team: 1_610_612_744)

      assert_kind_of Collection, result
    end

    def test_players_off_court_returns_player_summary_objects
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: players_off_response.to_json)

      result = TeamPlayerOnOffSummary.players_off_court(team: 1_610_612_744)

      assert_kind_of TeamOnOffPlayerSummary, result.first
    end

    private

    def overall_response
      hdrs = %w[GROUP_SET GROUP_VALUE TEAM_ID TEAM_ABBREVIATION TEAM_NAME GP W L]
      row = ["Overall", "On Court", 1_610_612_744, "GSW", "Warriors", 82, 46, 36]
      {resultSets: [{name: "OverallTeamPlayerOnOffSummary", headers: hdrs, rowSet: [row]}]}
    end

    def player_headers
      %w[GROUP_SET TEAM_ID TEAM_ABBREVIATION TEAM_NAME VS_PLAYER_ID VS_PLAYER_NAME
        COURT_STATUS GP MIN PLUS_MINUS OFF_RATING DEF_RATING NET_RATING]
    end

    def players_on_response
      row = ["On", 1_610_612_744, "GSW", "Warriors", 201_566, "Russell Westbrook", "On",
        20, 48.0, 5.5, 115.2, 108.7, 6.5]
      {resultSets: [{name: "PlayersOnCourtTeamPlayerOnOffSummary", headers: player_headers, rowSet: [row]}]}
    end

    def players_off_response
      row = ["Off", 1_610_612_744, "GSW", "Warriors", 201_566, "Russell Westbrook", "Off",
        62, 192.0, 0.8, 110.5, 112.3, -1.8]
      {resultSets: [{name: "PlayersOffCourtTeamPlayerOnOffSummary", headers: player_headers, rowSet: [row]}]}
    end
  end
end
