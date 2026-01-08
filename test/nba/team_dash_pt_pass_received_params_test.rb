require_relative "../test_helper"

module NBA
  class TeamDashPtPassReceivedParamsTest < Minitest::Test
    cover TeamDashPtPass

    def test_passes_received_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      TeamDashPtPass.passes_received(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_passes_received_includes_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: response.to_json)
      TeamDashPtPass.passes_received(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_passes_received_includes_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: response.to_json)
      TeamDashPtPass.passes_received(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_passes_received_custom_season_type
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: response.to_json)
      TeamDashPtPass.passes_received(team: 1_610_612_744, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_passes_received_custom_per_mode
      stub_request(:get, /PerMode=Totals/).to_return(body: response.to_json)
      TeamDashPtPass.passes_received(team: 1_610_612_744, per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
    end

    private

    def response
      {resultSets: [{name: "PassesReceived", headers: headers, rowSet: [row]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME PASS_TYPE G PASS_TO PASS_TEAMMATE_PLAYER_ID FREQUENCY PASS AST
        FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", "Received", 82, "Klay Thompson", 202_691, 0.12, 4.8, 1.9,
        3.2, 6.8, 0.471, 1.3, 2.8, 0.464, 1.9, 4.0, 0.475]
    end
  end
end
