require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffDetailsParamsTest < Minitest::Test
    cover TeamPlayerOnOffDetails

    def test_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_extracts_id_from_team_object
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      team = Team.new(id: 1_610_612_744)
      TeamPlayerOnOffDetails.overall(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_includes_season_in_path
      stub_request(:get, /Season=2024-25/).to_return(body: response.to_json)
      TeamPlayerOnOffDetails.overall(team: 1_610_612_744, season: 2024)

      assert_requested :get, /Season=2024-25/
    end

    def test_includes_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: response.to_json)
      TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_includes_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: response.to_json)
      TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_includes_league_id_in_path
      stub_request(:get, /LeagueID=00/).to_return(body: response.to_json)
      TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_requested :get, /LeagueID=00/
    end

    def test_custom_season_type
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: response.to_json)
      TeamPlayerOnOffDetails.overall(team: 1_610_612_744, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_custom_per_mode
      stub_request(:get, /PerMode=Totals/).to_return(body: response.to_json)
      TeamPlayerOnOffDetails.overall(team: 1_610_612_744, per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
    end

    private

    def response
      hdrs = %w[GROUP_SET GROUP_VALUE TEAM_ID TEAM_ABBREVIATION TEAM_NAME GP W L]
      row = ["Overall", "On Court", 1_610_612_744, "GSW", "Warriors", 82, 46, 36]
      {resultSets: [{name: "OverallTeamPlayerOnOffDetails", headers: hdrs, rowSet: [row]}]}
    end
  end
end
