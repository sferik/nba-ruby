require_relative "../test_helper"

module NBA
  class GameLogPlayerHydrationTest < Minitest::Test
    cover GameLog

    def test_player_returns_hydrated_player_object
      stub_player_info_request(201_939)
      log = GameLog.new(player_id: 201_939)

      player = log.player

      assert_instance_of Player, player
      assert_equal 201_939, player.id
    end

    def test_player_calls_api_with_correct_player_id
      stub_player_info_request(201_939)
      log = GameLog.new(player_id: 201_939)

      log.player

      assert_requested :get, /commonplayerinfo.*PlayerID=201939/
    end

    def test_player_returns_nil_when_player_id_is_nil
      log = GameLog.new(player_id: nil)

      assert_nil log.player
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
      [player_id, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson", "USA", 2009, 1, 7]
    end
  end
end
