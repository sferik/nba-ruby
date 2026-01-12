require_relative "../../test_helper"

module NBA
  class PlayPlayer3HydrationTest < Minitest::Test
    cover Play

    def test_player3_returns_hydrated_player_object
      stub_player_info_request(203_507)
      play = Play.new(player3_id: 203_507)

      player = play.player3

      assert_instance_of Player, player
      assert_equal 203_507, player.id
    end

    def test_player3_calls_api_with_correct_player_id
      stub_player_info_request(203_507)
      play = Play.new(player3_id: 203_507)

      play.player3

      assert_requested :get, /commonplayerinfo.*PlayerID=203507/
    end

    def test_player3_returns_nil_when_player3_id_is_nil
      play = Play.new(player3_id: nil)

      assert_nil play.player3
    end

    private

    def stub_player_info_request(player_id)
      response = {resultSets: [{headers: player_info_headers, rowSet: [player_info_row(player_id)]}]}
      stub_request(:get, /commonplayerinfo.*PlayerID=#{player_id}/).to_return(body: response.to_json)
    end

    def player_info_headers
      %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND
        DRAFT_NUMBER]
    end

    def player_info_row(player_id)
      [player_id, "Giannis Antetokounmpo", "Giannis", "Antetokounmpo", "Active", "34", "6-11", 243, "N/A", "Greece", 2013, 1, 15]
    end
  end
end
