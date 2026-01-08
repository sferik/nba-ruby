require_relative "../test_helper"

module NBA
  class TeamDashPtShotsParamsTest < Minitest::Test
    cover TeamDashPtShots

    def test_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)

      TeamDashPtShots.general(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_extracts_id_from_team_object
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      team = Team.new(id: 1_610_612_744)

      TeamDashPtShots.general(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_includes_season_in_path
      stub_request(:get, /Season=2024-25/).to_return(body: response.to_json)

      TeamDashPtShots.general(team: 1_610_612_744, season: 2024)

      assert_requested :get, /Season=2024-25/
    end

    def test_includes_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: response.to_json)

      TeamDashPtShots.general(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_includes_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: response.to_json)

      TeamDashPtShots.general(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_includes_league_id_in_path
      stub_request(:get, /LeagueID=00/).to_return(body: response.to_json)

      TeamDashPtShots.general(team: 1_610_612_744)

      assert_requested :get, /LeagueID=00/
    end

    def test_custom_season_type
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: response.to_json)

      TeamDashPtShots.general(team: 1_610_612_744, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_custom_per_mode
      stub_request(:get, /PerMode=Totals/).to_return(body: response.to_json)

      TeamDashPtShots.general(team: 1_610_612_744, per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
    end

    private

    def response
      {resultSets: [{name: "GeneralShooting", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION SORT_ORDER G SHOT_TYPE FGA_FREQUENCY
        FGM FGA FG_PCT EFG_PCT FG2A_FREQUENCY FG2M FG2A FG2_PCT
        FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", "GSW", 1, 82, "Catch and Shoot", 0.35,
        7.2, 15.3, 0.472, 0.561, 0.45, 4.1, 7.8, 0.526, 0.55, 4.8, 11.2, 0.428]
    end
  end
end
