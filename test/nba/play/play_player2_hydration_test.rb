require_relative "../../test_helper"

module NBA
  class PlayPlayer2HydrationTest < Minitest::Test
    cover Play

    def test_player2_returns_hydrated_player_object
      stub_player_info_request(2544)
      play = Play.new(player2_id: 2544)

      player = play.player2

      assert_instance_of Player, player
      assert_equal 2544, player.id
    end

    def test_player2_calls_api_with_correct_player_id
      stub_player_info_request(2544)
      play = Play.new(player2_id: 2544)

      play.player2

      assert_requested :get, /commonplayerinfo.*PlayerID=2544/
    end

    def test_player2_returns_nil_when_player2_id_is_nil
      play = Play.new(player2_id: nil)

      assert_nil play.player2
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
      [player_id, "LeBron James", "LeBron", "James", "Active", "23", "6-9", 250, "N/A", "USA", 2003, 1, 1]
    end
  end
end
