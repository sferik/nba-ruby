require_relative "../test_helper"

module NBA
  class TeamDashPtPassShootingTest < Minitest::Test
    cover TeamDashPtPass

    def test_extracts_fg2m
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 1.5, result.fg2m
    end

    def test_extracts_fg2a
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 3.0, result.fg2a
    end

    def test_extracts_fg2_pct
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 0.5, result.fg2_pct
    end

    def test_extracts_fg3m
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 2.0, result.fg3m
    end

    def test_extracts_fg3a
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 4.2, result.fg3a
    end

    def test_extracts_fg3_pct
      stub_request(:get, /teamdashptpass/).to_return(body: response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_in_delta 0.476, result.fg3_pct
    end

    def test_extracts_pass_to_from_received_result_set
      stub_request(:get, /teamdashptpass/).to_return(body: received_response.to_json)

      result = TeamDashPtPass.passes_received(team: 1_610_612_744).first

      assert_equal "Klay Thompson", result.pass_to
    end

    private

    def response
      {resultSets: [{name: "PassesMade", headers: headers, rowSet: [row]}]}
    end

    def received_response
      {resultSets: [{name: "PassesReceived", headers: headers_received, rowSet: [row_received]}]}
    end

    def headers
      %w[TEAM_ID TEAM_NAME PASS_TYPE G PASS_FROM PASS_TEAMMATE_PLAYER_ID FREQUENCY PASS AST
        FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def headers_received
      %w[TEAM_ID TEAM_NAME PASS_TYPE G PASS_TO PASS_TEAMMATE_PLAYER_ID FREQUENCY PASS AST
        FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def row
      [1_610_612_744, "Golden State Warriors", "Made", 82, "Stephen Curry", 201_939, 0.15, 5.2, 2.1,
        3.5, 7.2, 0.486, 1.5, 3.0, 0.5, 2.0, 4.2, 0.476]
    end

    def row_received
      [1_610_612_744, "Golden State Warriors", "Received", 82, "Klay Thompson", 202_691, 0.12, 4.8, 1.9,
        3.2, 6.8, 0.471, 1.3, 2.8, 0.464, 1.9, 4.0, 0.475]
    end
  end
end
