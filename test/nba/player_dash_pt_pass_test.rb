require_relative "../test_helper"

module NBA
  class PlayerDashPtPassTest < Minitest::Test
    cover PlayerDashPtPass

    def test_passes_made_parses_player_id
      assert_equal 201_939, passes_made_stat.player_id
    end

    def test_passes_made_parses_player_name
      assert_equal "Curry, Stephen", passes_made_stat.player_name_last_first
    end

    def test_passes_made_parses_team_id
      assert_equal 1_610_612_744, passes_made_stat.team_id
    end

    def test_passes_made_parses_team_abbreviation
      assert_equal "GSW", passes_made_stat.team_abbreviation
    end

    def test_passes_made_parses_pass_teammate_player_id
      assert_equal 202_691, passes_made_stat.pass_teammate_player_id
    end

    def test_passes_received_parses_player_id
      assert_equal 201_939, passes_received_stat.player_id
    end

    def test_passes_received_parses_pass_to
      assert_equal "Draymond Green", passes_received_stat.pass_to
    end

    def test_passes_received_parses_pass
      assert_in_delta 3.8, passes_received_stat.pass
    end

    def test_passes_made_returns_collection
      stub_passes_made_request

      assert_instance_of Collection, PlayerDashPtPass.passes_made(player: 201_939)
    end

    def test_passes_received_returns_collection
      stub_passes_received_request

      assert_instance_of Collection, PlayerDashPtPass.passes_received(player: 201_939)
    end

    def test_passes_made_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = PlayerDashPtPass.passes_made(player: 201_939, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_passes_made_returns_empty_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      result = PlayerDashPtPass.passes_made(player: 201_939, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    private

    def passes_made_stat
      stub_passes_made_request
      PlayerDashPtPass.passes_made(player: 201_939).first
    end

    def passes_received_stat
      stub_passes_received_request
      PlayerDashPtPass.passes_received(player: 201_939).first
    end

    def stub_passes_made_request
      stub_request(:get, /playerdashptpass.*PlayerID=201939/).to_return(body: passes_made_response.to_json)
    end

    def stub_passes_received_request
      stub_request(:get, /playerdashptpass.*PlayerID=201939/).to_return(body: passes_received_response.to_json)
    end

    def passes_made_response
      {resultSets: [{name: "PassesMade", headers: headers,
                     rowSet: [[201_939, "Curry, Stephen", 1_610_612_744, "GSW", 202_691, "Klay Thompson",
                       74, 74, "Made", 0.25, 5.2, 2.1, 3.5, 7.2, 0.486, 1.5, 3.0, 0.500, 2.0, 4.2, 0.476]]}]}
    end

    def passes_received_response
      {resultSets: [{name: "PassesReceived", headers: headers,
                     rowSet: [[201_939, "Curry, Stephen", 1_610_612_744, "GSW", 203_110, "Draymond Green",
                       74, 74, "Received", 0.20, 3.8, 1.5, 2.8, 5.5, 0.509, 1.2, 2.5, 0.480, 1.6, 3.0, 0.533]]}]}
    end

    def headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST TEAM_ID TEAM_ABBREVIATION PASS_TEAMMATE_PLAYER_ID
        PASS_TO GP G PASS_TYPE FREQUENCY PASS AST FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end
  end
end
