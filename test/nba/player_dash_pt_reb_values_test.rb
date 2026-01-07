require_relative "../test_helper"

module NBA
  class PlayerDashPtRebValuesTest < Minitest::Test
    cover PlayerDashPtReb

    def test_num_contested_values
      stub_request(:get, /playerdashptreb/).to_return(body: num_contested_response.to_json)
      stat = PlayerDashPtReb.num_contested(player: 201_939).first

      assert_equal 201_939, stat.player_id
      assert_equal 1, stat.sort_order
      assert_equal "0 Contests", stat.reb_num_contesting_range
    end

    def test_reb_distance_values
      stub_request(:get, /playerdashptreb/).to_return(body: reb_distance_response.to_json)
      stat = PlayerDashPtReb.reb_distance(player: 201_939).first

      assert_equal 201_939, stat.player_id
      assert_equal 1, stat.sort_order
      assert_equal "0-6 Feet", stat.reb_dist_range
    end

    def test_shot_distance_values
      stub_request(:get, /playerdashptreb/).to_return(body: shot_distance_response.to_json)
      stat = PlayerDashPtReb.shot_distance(player: 201_939).first

      assert_equal 201_939, stat.player_id
      assert_equal 1, stat.sort_order
      assert_equal "0-6 Feet", stat.shot_dist_range
    end

    def test_shot_type_values
      stub_request(:get, /playerdashptreb/).to_return(body: shot_type_response.to_json)
      stat = PlayerDashPtReb.shot_type(player: 201_939).first

      assert_equal 201_939, stat.player_id
      assert_equal 1, stat.sort_order
      assert_equal "2PT FGs", stat.shot_type_range
    end

    private

    def num_contested_response
      {resultSets: [{
        name: "NumContestedRebounding",
        headers: %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G REB_NUM_CONTESTING_RANGE REB_FREQUENCY],
        rowSet: [[201_939, "Curry, Stephen", 1, 74, "0 Contests", 0.25]]
      }]}
    end

    def reb_distance_response
      {resultSets: [{
        name: "RebDistanceRebounding",
        headers: %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G REB_DIST_RANGE REB_FREQUENCY],
        rowSet: [[201_939, "Curry, Stephen", 1, 74, "0-6 Feet", 0.25]]
      }]}
    end

    def shot_distance_response
      {resultSets: [{
        name: "ShotDistanceRebounding",
        headers: %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G SHOT_DIST_RANGE REB_FREQUENCY],
        rowSet: [[201_939, "Curry, Stephen", 1, 74, "0-6 Feet", 0.25]]
      }]}
    end

    def shot_type_response
      {resultSets: [{
        name: "ShotTypeRebounding",
        headers: %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G SHOT_TYPE_RANGE REB_FREQUENCY],
        rowSet: [[201_939, "Curry, Stephen", 1, 74, "2PT FGs", 0.25]]
      }]}
    end
  end
end
