require_relative "../test_helper"

module NBA
  class TeamPlayerOnOffSummaryParamsTest < Minitest::Test
    cover TeamPlayerOnOffSummary

    def test_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_extracts_id_from_team_object
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      team = Team.new(id: 1_610_612_744)
      TeamPlayerOnOffSummary.overall(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_includes_season_in_path
      stub_request(:get, /Season=2024-25/).to_return(body: response.to_json)
      TeamPlayerOnOffSummary.overall(team: 1_610_612_744, season: 2024)

      assert_requested :get, /Season=2024-25/
    end

    def test_includes_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: response.to_json)
      TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_includes_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: response.to_json)
      TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_includes_league_id_in_path
      stub_request(:get, /LeagueID=00/).to_return(body: response.to_json)
      TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_requested :get, /LeagueID=00/
    end

    def test_custom_season_type
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: response.to_json)
      TeamPlayerOnOffSummary.overall(team: 1_610_612_744, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_custom_per_mode
      stub_request(:get, /PerMode=Totals/).to_return(body: response.to_json)
      TeamPlayerOnOffSummary.overall(team: 1_610_612_744, per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
    end

    def test_players_on_court_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: players_on_response.to_json)
      TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_players_off_court_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: players_off_response.to_json)
      TeamPlayerOnOffSummary.players_off_court(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    private

    def response
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
