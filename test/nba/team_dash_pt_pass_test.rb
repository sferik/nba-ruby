require_relative "../test_helper"

module NBA
  class TeamDashPtPassTest < Minitest::Test
    cover TeamDashPtPass

    def test_passes_made_returns_collection
      stub_request(:get, /teamdashptpass/).to_return(body: passes_made_response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744)

      assert_instance_of Collection, result
    end

    def test_passes_received_returns_collection
      stub_request(:get, /teamdashptpass/).to_return(body: passes_received_response.to_json)

      result = TeamDashPtPass.passes_received(team: 1_610_612_744)

      assert_instance_of Collection, result
    end

    def test_passes_made_returns_team_pass_stat_objects
      stub_request(:get, /teamdashptpass/).to_return(body: passes_made_response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744)

      assert_instance_of TeamPassStat, result.first
    end

    def test_passes_received_returns_team_pass_stat_objects
      stub_request(:get, /teamdashptpass/).to_return(body: passes_received_response.to_json)

      result = TeamDashPtPass.passes_received(team: 1_610_612_744)

      assert_instance_of TeamPassStat, result.first
    end

    def test_passes_made_returns_empty_collection_for_nil_response
      stub_request(:get, /teamdashptpass/).to_return(body: nil)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744)

      assert_empty result
    end

    def test_passes_received_returns_empty_collection_for_empty_response
      stub_request(:get, /teamdashptpass/).to_return(body: "")

      result = TeamDashPtPass.passes_received(team: 1_610_612_744)

      assert_empty result
    end

    def test_passes_made_returns_empty_collection_for_missing_result_set
      stub_request(:get, /teamdashptpass/).to_return(body: empty_response.to_json)

      result = TeamDashPtPass.passes_made(team: 1_610_612_744)

      assert_empty result
    end

    private

    def passes_made_response
      {resultSets: [{name: "PassesMade", headers: pass_headers_made, rowSet: [pass_row_made]}]}
    end

    def passes_received_response
      {resultSets: [{name: "PassesReceived", headers: pass_headers_received, rowSet: [pass_row_received]}]}
    end

    def empty_response
      {resultSets: [{name: "OtherResultSet", headers: [], rowSet: []}]}
    end

    def pass_headers_made
      %w[TEAM_ID TEAM_NAME PASS_TYPE G PASS_FROM PASS_TEAMMATE_PLAYER_ID FREQUENCY PASS AST
        FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def pass_headers_received
      %w[TEAM_ID TEAM_NAME PASS_TYPE G PASS_TO PASS_TEAMMATE_PLAYER_ID FREQUENCY PASS AST
        FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def pass_row_made
      [1_610_612_744, "Golden State Warriors", "Made", 82, "Stephen Curry", 201_939, 0.15, 5.2, 2.1,
        3.5, 7.2, 0.486, 1.5, 3.0, 0.5, 2.0, 4.2, 0.476]
    end

    def pass_row_received
      [1_610_612_744, "Golden State Warriors", "Received", 82, "Klay Thompson", 202_691, 0.12, 4.8, 1.9,
        3.2, 6.8, 0.471, 1.3, 2.8, 0.464, 1.9, 4.0, 0.475]
    end
  end
end
