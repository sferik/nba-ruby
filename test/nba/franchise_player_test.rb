require_relative "../test_helper"

module NBA
  class FranchisePlayerTest < Minitest::Test
    cover FranchisePlayer

    def test_objects_with_same_person_id_are_equal
      player0 = FranchisePlayer.new(person_id: 201_939)
      player1 = FranchisePlayer.new(person_id: 201_939)

      assert_equal player0, player1
    end

    def test_objects_with_different_person_id_are_not_equal
      player0 = FranchisePlayer.new(person_id: 201_939)
      player1 = FranchisePlayer.new(person_id: 2544)

      refute_equal player0, player1
    end

    def test_player_info_returns_player_object
      stub_player_request
      player = FranchisePlayer.new(person_id: 201_939)

      player_info = player.player_info

      assert_instance_of Player, player_info
      assert_equal 201_939, player_info.id
    end

    def test_player_info_returns_nil_when_person_id_is_nil
      player = FranchisePlayer.new(person_id: nil)

      assert_nil player.player_info
    end

    private

    def stub_player_request
      response = {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID], rowSet: [[201_939]]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)
    end
  end
end
