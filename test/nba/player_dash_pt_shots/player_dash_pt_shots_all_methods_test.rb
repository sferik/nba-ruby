require_relative "../../test_helper"

module NBA
  class PlayerDashPtShotsAllMethodsTest < Minitest::Test
    cover PlayerDashPtShots

    def test_general_includes_player_id_in_path
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.general(player: 201_939)

      assert_requested request
    end

    def test_general_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.general(player: player)

      assert_requested request
      player.verify
    end

    def test_dribble_includes_player_id_in_path
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.dribble(player: 201_939)

      assert_requested request
    end

    def test_dribble_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.dribble(player: player)

      assert_requested request
      player.verify
    end

    def test_touch_time_includes_player_id_in_path
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.touch_time(player: 201_939)

      assert_requested request
    end

    def test_touch_time_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.touch_time(player: player)

      assert_requested request
      player.verify
    end

    def test_shot_clock_includes_player_id_in_path
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.shot_clock(player: 201_939)

      assert_requested request
    end

    def test_shot_clock_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.shot_clock(player: player)

      assert_requested request
      player.verify
    end

    def test_closest_defender_includes_player_id_in_path
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender(player: 201_939)

      assert_requested request
    end

    def test_closest_defender_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender(player: player)

      assert_requested request
      player.verify
    end

    def test_closest_defender_10ft_includes_player_id_in_path
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender_10ft(player: 201_939)

      assert_requested request
    end

    def test_closest_defender_10ft_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerdashptshots.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShots.closest_defender_10ft(player: player)

      assert_requested request
      player.verify
    end

    private

    def empty_response
      {resultSets: [{name: "Overall", headers: [], rowSet: []}]}
    end
  end
end
