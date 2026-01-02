require_relative "../test_helper"

module NBA
  class AwardTest < Minitest::Test
    cover Award

    def test_objects_with_same_player_id_description_and_season_are_equal
      award0 = Award.new(player_id: 201_939, description: "MVP", season: "2021-22")
      award1 = Award.new(player_id: 201_939, description: "MVP", season: "2021-22")

      assert_equal award0, award1
    end

    def test_objects_with_different_season_are_not_equal
      award0 = Award.new(player_id: 201_939, description: "MVP", season: "2021-22")
      award1 = Award.new(player_id: 201_939, description: "MVP", season: "2020-21")

      refute_equal award0, award1
    end

    def test_player_returns_player_object
      stub_request(:get, %r{stats\.nba\.com/stats/commonplayerinfo}).to_return(body: player_info_response.to_json)
      award = Award.new(player_id: 201_939)

      player = award.player

      assert_instance_of Player, player
      assert_equal 201_939, player.id
    end

    def test_player_returns_nil_when_player_id_is_nil
      award = Award.new(player_id: nil)

      assert_nil award.player
    end

    private

    def player_info_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT
        WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER]
      row = [201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson", "USA", 2009, 1, 7]
      {resultSets: [{headers: headers, rowSet: [row]}]}
    end
  end
end
