require_relative "../test_helper"

module NBA
  class TeamDashPtPassKeysTest < Minitest::Test
    cover TeamDashPtPass

    def test_handles_missing_team_id_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("TEAM_ID").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.team_id
    end

    def test_handles_missing_team_name_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("TEAM_NAME").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.team_name
    end

    def test_handles_missing_pass_type_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("PASS_TYPE").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.pass_type
    end

    def test_handles_missing_g_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("G").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.g
    end

    def test_handles_missing_pass_teammate_player_id_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("PASS_TEAMMATE_PLAYER_ID").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.pass_teammate_player_id
    end

    def test_handles_missing_pass_from_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("PASS_FROM").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.pass_from
    end

    def test_handles_missing_pass_to_key
      stub_request(:get, /teamdashptpass/).to_return(body: received_response_missing_key("PASS_TO").to_json)

      result = TeamDashPtPass.passes_received(team: 1_610_612_744).first

      assert_nil result.pass_to
    end

    def test_handles_missing_frequency_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("FREQUENCY").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.frequency
    end

    def test_handles_missing_pass_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("PASS").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.pass
    end

    def test_handles_missing_ast_key
      stub_request(:get, /teamdashptpass/).to_return(body: response_missing_key("AST").to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744).first

      assert_nil result.ast
    end

    private

    def response_missing_key(key)
      hdrs = headers.reject { |h| h == key }
      rw = row.each_with_index.reject { |_, i| headers[i] == key }.map(&:first)
      {resultSets: [{name: "PassesMade", headers: hdrs, rowSet: [rw]}]}
    end

    def received_response_missing_key(key)
      hdrs = headers_received.reject { |h| h == key }
      rw = row_received.each_with_index.reject { |_, i| headers_received[i] == key }.map(&:first)
      {resultSets: [{name: "PassesReceived", headers: hdrs, rowSet: [rw]}]}
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
