require_relative "../test_helper"

module NBA
  class TeamDashPtPassParamsTest < Minitest::Test
    cover TeamDashPtPass

    def test_includes_team_id_in_path
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      TeamDashPtPass.passes_made(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_extracts_id_from_team_object
      stub_request(:get, /TeamID=1610612744/).to_return(body: response.to_json)
      team = Team.new(id: 1_610_612_744)
      TeamDashPtPass.passes_made(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_includes_season_in_path
      stub_request(:get, /Season=2024-25/).to_return(body: response.to_json)
      TeamDashPtPass.passes_made(team: 1_610_612_744, season: 2024)

      assert_requested :get, /Season=2024-25/
    end

    def test_includes_season_type_in_path
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: response.to_json)
      TeamDashPtPass.passes_made(team: 1_610_612_744)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_includes_per_mode_in_path
      stub_request(:get, /PerMode=PerGame/).to_return(body: response.to_json)
      TeamDashPtPass.passes_made(team: 1_610_612_744)

      assert_requested :get, /PerMode=PerGame/
    end

    def test_includes_league_id_in_path
      stub_request(:get, /LeagueID=00/).to_return(body: response.to_json)
      TeamDashPtPass.passes_made(team: 1_610_612_744)

      assert_requested :get, /LeagueID=00/
    end

    def test_passes_made_uses_passes_made_result_set
      stub = stub_request(:get, /teamdashptpass/).to_return(body: passes_made_response.to_json)
      result = TeamDashPtPass.passes_made(team: 1_610_612_744)

      assert_requested stub
      assert_equal "Stephen Curry", result.first.pass_from
    end

    def test_passes_received_uses_passes_received_result_set
      stub = stub_request(:get, /teamdashptpass/).to_return(body: passes_received_response.to_json)
      result = TeamDashPtPass.passes_received(team: 1_610_612_744)

      assert_requested stub
      assert_equal "Klay Thompson", result.first.pass_to
    end

    def test_custom_season_type
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: response.to_json)
      TeamDashPtPass.passes_made(team: 1_610_612_744, season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_custom_per_mode
      stub_request(:get, /PerMode=Totals/).to_return(body: response.to_json)
      TeamDashPtPass.passes_made(team: 1_610_612_744, per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
    end

    private

    def response
      {resultSets: [{name: "PassesMade", headers: headers, rowSet: [row]}]}
    end

    def passes_made_response
      {resultSets: [{name: "PassesMade", headers: headers, rowSet: [row]}]}
    end

    def passes_received_response
      {resultSets: [{name: "PassesReceived", headers: received_headers, rowSet: [received_row]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME PASS_TYPE G PASS_FROM PASS_TEAMMATE_PLAYER_ID FREQUENCY PASS AST
        FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def received_headers
      %w[TEAM_ID TEAM_NAME PASS_TYPE G PASS_TO PASS_TEAMMATE_PLAYER_ID FREQUENCY PASS AST
        FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", "Made", 82, "Stephen Curry", 201_939, 0.15, 5.2, 2.1,
        3.5, 7.2, 0.486, 1.5, 3.0, 0.5, 2.0, 4.2, 0.476]
    end

    def received_row
      [1_610_612_744, "Golden State Warriors", "Received", 82, "Klay Thompson", 202_691, 0.12, 4.8, 1.9,
        3.2, 6.8, 0.471, 1.3, 2.8, 0.464, 1.9, 4.0, 0.475]
    end
  end
end
