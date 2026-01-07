require_relative "../test_helper"

module NBA
  class PlayerDashPtRebTest < Minitest::Test
    cover PlayerDashPtReb

    def test_overall_returns_collection
      stub_overall_request
      result = PlayerDashPtReb.overall(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_num_contested_returns_collection
      stub_num_contested_request
      result = PlayerDashPtReb.num_contested(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_reb_distance_returns_collection
      stub_reb_distance_request
      result = PlayerDashPtReb.reb_distance(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_shot_distance_returns_collection
      stub_shot_distance_request
      result = PlayerDashPtReb.shot_distance(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_shot_type_returns_collection
      stub_shot_type_request
      result = PlayerDashPtReb.shot_type(player: 201_939)

      assert_instance_of Collection, result
    end

    def test_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = PlayerDashPtReb.overall(player: 201_939, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_returns_empty_collection_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      result = PlayerDashPtReb.overall(player: 201_939, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    private

    def stub_overall_request
      stub_request(:get, /playerdashptreb.*PlayerID=201939/)
        .to_return(body: overall_response.to_json)
    end

    def stub_num_contested_request
      stub_request(:get, /playerdashptreb.*PlayerID=201939/)
        .to_return(body: num_contested_response.to_json)
    end

    def stub_reb_distance_request
      stub_request(:get, /playerdashptreb.*PlayerID=201939/)
        .to_return(body: reb_distance_response.to_json)
    end

    def stub_shot_distance_request
      stub_request(:get, /playerdashptreb.*PlayerID=201939/)
        .to_return(body: shot_distance_response.to_json)
    end

    def stub_shot_type_request
      stub_request(:get, /playerdashptreb.*PlayerID=201939/)
        .to_return(body: shot_type_response.to_json)
    end

    def overall_response
      {resultSets: [{
        name: "OverallRebounding",
        headers: %w[PLAYER_ID PLAYER_NAME_LAST_FIRST G OVERALL REB_FREQUENCY],
        rowSet: [[201_939, "Curry, Stephen", 74, "Overall", 0.25]]
      }]}
    end

    def num_contested_response
      {resultSets: [{
        name: "NumContestedRebounding",
        headers: %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G REB_NUM_CONTESTING_RANGE],
        rowSet: [[201_939, "Curry, Stephen", 1, 74, "0 Contests"]]
      }]}
    end

    def reb_distance_response
      {resultSets: [{
        name: "RebDistanceRebounding",
        headers: %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G REB_DIST_RANGE],
        rowSet: [[201_939, "Curry, Stephen", 1, 74, "0-6 Feet"]]
      }]}
    end

    def shot_distance_response
      {resultSets: [{
        name: "ShotDistanceRebounding",
        headers: %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G SHOT_DIST_RANGE],
        rowSet: [[201_939, "Curry, Stephen", 1, 74, "0-6 Feet"]]
      }]}
    end

    def shot_type_response
      {resultSets: [{
        name: "ShotTypeRebounding",
        headers: %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G SHOT_TYPE_RANGE],
        rowSet: [[201_939, "Curry, Stephen", 1, 74, "2PT FGs"]]
      }]}
    end
  end
end
