require_relative "../test_helper"

module NBA
  class DraftCombineAnthroMeasurementModelTest < Minitest::Test
    cover DraftCombineAnthroMeasurement

    def test_objects_with_same_player_id_are_equal
      measurement0 = DraftCombineAnthroMeasurement.new(player_id: 1_630_162)
      measurement1 = DraftCombineAnthroMeasurement.new(player_id: 1_630_162)

      assert_equal measurement0, measurement1
    end

    def test_objects_with_different_player_id_are_not_equal
      measurement0 = DraftCombineAnthroMeasurement.new(player_id: 1_630_162)
      measurement1 = DraftCombineAnthroMeasurement.new(player_id: 1_630_163)

      refute_equal measurement0, measurement1
    end

    def test_player_returns_nil_when_player_id_is_nil
      measurement = DraftCombineAnthroMeasurement.new(player_id: nil)

      assert_nil measurement.player
    end

    def test_player_returns_player_object_when_player_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      measurement = DraftCombineAnthroMeasurement.new(player_id: 1_630_162)
      player = measurement.player

      assert_instance_of Player, player
      assert_equal 1_630_162, player.id
    end

    def test_player_uses_player_id_attribute
      stub_request(:get, /commonplayerinfo\?PlayerID=1630162/).to_return(body: player_response.to_json)

      measurement = DraftCombineAnthroMeasurement.new(player_id: 1_630_162)
      measurement.player

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
