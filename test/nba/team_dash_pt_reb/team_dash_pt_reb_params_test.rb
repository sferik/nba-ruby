require_relative "../../test_helper"

module NBA
  class TeamDashPtRebParamsTest < Minitest::Test
    cover TeamDashPtReb

    def test_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_extracts_id_from_team_object
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      team = Team.new(id: 1_610_612_744)
      TeamDashPtReb.num_contested(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_includes_season_in_path
      stub_request(:get, /Season=2024-25/).to_return(body: response.to_json)
      TeamDashPtReb.num_contested(team: 1_610_612_744, season: 2024)

      assert_requested :get, /Season=2024-25/
    end

    def test_includes_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: response.to_json)
      TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_includes_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: response.to_json)
      TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_includes_league_id_in_path
      stub_request(:get, /LeagueID=00/).to_return(body: response.to_json)
      TeamDashPtReb.num_contested(team: 1_610_612_744)

      assert_requested :get, /LeagueID=00/
    end

    def test_custom_season_type
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: response.to_json)
      TeamDashPtReb.num_contested(team: 1_610_612_744, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_custom_per_mode
      stub_request(:get, /PerMode=Totals/).to_return(body: response.to_json)
      TeamDashPtReb.num_contested(team: 1_610_612_744, per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
    end

    def test_overall_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: overall_response.to_json)
      TeamDashPtReb.overall(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_overall_includes_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: overall_response.to_json)
      TeamDashPtReb.overall(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_overall_includes_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: overall_response.to_json)
      TeamDashPtReb.overall(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_overall_custom_season_type
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: overall_response.to_json)
      TeamDashPtReb.overall(team: 1_610_612_744, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_overall_custom_per_mode
      stub_request(:get, /PerMode=Totals/).to_return(body: overall_response.to_json)
      TeamDashPtReb.overall(team: 1_610_612_744, per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
    end

    private

    def response
      {resultSets: [{name: "NumContestedRebounding", headers: headers, rowSet: [row]}]}
    end

    def overall_response
      {resultSets: [{name: "OverallRebounding", headers: overall_headers, rowSet: [overall_row]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME SORT_ORDER G REB_NUM_CONTESTING_RANGE REB_FREQUENCY
        OREB DREB REB C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def overall_headers
      %w[TEAM_ID TEAM_NAME G OVERALL REB_FREQUENCY OREB DREB REB
        C_OREB C_DREB C_REB C_REB_PCT UC_OREB UC_DREB UC_REB UC_REB_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", 1, 82, "0 Contests", 0.25,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end

    def overall_row
      [1_610_612_744, "Golden State Warriors", 82, "Overall", 1.0,
        10.5, 35.2, 45.7, 5.2, 18.1, 23.3, 0.51, 5.3, 17.1, 22.4, 0.49]
    end
  end
end
