require_relative "../test_helper"

module NBA
  class TeamDashPtPassEdgeCasesTest < Minitest::Test
    cover TeamDashPtPass

    def test_returns_empty_when_headers_missing
      stub_request(:get, /teamdashptpass/).to_return(body: {resultSets: [{name: "PassesMade", rowSet: [row]}]}.to_json)

      assert_empty TeamDashPtPass.passes_made(team: 1_610_612_744)
    end

    def test_returns_empty_when_rowset_missing
      stub_request(:get, /teamdashptpass/).to_return(body: {resultSets: [{name: "PassesMade", headers: headers}]}.to_json)

      assert_empty TeamDashPtPass.passes_made(team: 1_610_612_744)
    end

    def test_returns_empty_when_result_sets_missing
      stub_request(:get, /teamdashptpass/).to_return(body: {parameters: {}}.to_json)

      assert_empty TeamDashPtPass.passes_made(team: 1_610_612_744)
    end

    def test_passes_made_finds_passes_made_result_set_by_name
      stub_request(:get, /teamdashptpass/).to_return(body: multiple_result_sets_response.to_json)

      assert_equal "Stephen Curry", TeamDashPtPass.passes_made(team: 1_610_612_744).first.pass_from
    end

    def test_passes_received_finds_passes_received_result_set_by_name
      stub_request(:get, /teamdashptpass/).to_return(body: multiple_result_sets_response.to_json)

      assert_equal "Klay Thompson", TeamDashPtPass.passes_received(team: 1_610_612_744).first.pass_to
    end

    def test_returns_empty_when_result_set_name_not_found
      stub_request(:get, /teamdashptpass/).to_return(body: {resultSets: [{name: "WrongName", headers: headers, rowSet: [row]}]}.to_json)

      assert_empty TeamDashPtPass.passes_made(team: 1_610_612_744)
    end

    def test_returns_empty_when_headers_nil
      stub_request(:get, /teamdashptpass/).to_return(body: {resultSets: [{name: "PassesMade", headers: nil, rowSet: [row]}]}.to_json)

      assert_empty TeamDashPtPass.passes_made(team: 1_610_612_744)
    end

    def test_returns_empty_when_rowset_nil
      stub_request(:get, /teamdashptpass/).to_return(body: {resultSets: [{name: "PassesMade", headers: headers, rowSet: nil}]}.to_json)

      assert_empty TeamDashPtPass.passes_made(team: 1_610_612_744)
    end

    def test_returns_empty_when_result_set_has_no_name_key
      stub_request(:get, /teamdashptpass/).to_return(body: {resultSets: [{headers: headers, rowSet: [row]}]}.to_json)

      assert_empty TeamDashPtPass.passes_made(team: 1_610_612_744)
    end

    def test_returns_empty_when_client_returns_nil
      client = Minitest::Mock.new
      client.expect :get, nil, [String]

      assert_empty TeamDashPtPass.passes_made(team: 1_610_612_744, client: client)
      client.verify
    end

    private

    def multiple_result_sets_response
      {resultSets: [
        {name: "PassesMade", headers: headers, rowSet: [row]},
        {name: "PassesReceived", headers: received_headers, rowSet: [received_row]}
      ]}
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
