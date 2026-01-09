require_relative "../test_helper"

module NBA
  class DraftCombineStatModelTest < Minitest::Test
    cover DraftCombineStat

    def test_objects_with_same_player_id_are_equal
      stat0 = DraftCombineStat.new(player_id: 1_630_162)
      stat1 = DraftCombineStat.new(player_id: 1_630_162)

      assert_equal stat0, stat1
    end

    def test_objects_with_different_player_id_are_not_equal
      stat0 = DraftCombineStat.new(player_id: 1_630_162)
      stat1 = DraftCombineStat.new(player_id: 1_630_163)

      refute_equal stat0, stat1
    end

    def test_player_returns_nil_when_player_id_is_nil
      stat = DraftCombineStat.new(player_id: nil)

      assert_nil stat.player
    end

    def test_player_returns_player_object_when_player_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      stat = DraftCombineStat.new(player_id: 1_630_162)
      player = stat.player

      assert_instance_of Player, player
      assert_equal 1_630_162, player.id
    end

    def test_player_uses_player_id_attribute
      stub_request(:get, /commonplayerinfo\?PlayerID=1630162/).to_return(body: player_response.to_json)

      stat = DraftCombineStat.new(player_id: 1_630_162)
      stat.player

      assert_requested :get, /PlayerID=1630162/
    end

    private

    def player_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME]
      row = [1_630_162, "Victor Wembanyama", "Victor", "Wembanyama"]
      {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
    end
  end
end
