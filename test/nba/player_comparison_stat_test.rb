require_relative "../test_helper"

module NBA
  class PlayerComparisonStatTest < Minitest::Test
    cover PlayerComparisonStat

    def test_objects_with_same_player_id_and_season_id_are_equal
      stat0 = PlayerComparisonStat.new(player_id: 123, season_id: "2024-25")
      stat1 = PlayerComparisonStat.new(player_id: 123, season_id: "2024-25")

      assert_equal stat0, stat1
    end

    def test_objects_with_different_player_id_are_not_equal
      stat0 = PlayerComparisonStat.new(player_id: 123, season_id: "2024-25")
      stat1 = PlayerComparisonStat.new(player_id: 456, season_id: "2024-25")

      refute_equal stat0, stat1
    end

    def test_full_name_returns_combined_name
      stat = PlayerComparisonStat.new(first_name: "Stephen", last_name: "Curry")

      assert_equal "Stephen Curry", stat.full_name
    end

    def test_full_name_handles_nil_values
      stat = PlayerComparisonStat.new(first_name: nil, last_name: nil)

      assert_equal "", stat.full_name
    end

    def test_player_returns_nil_when_player_id_is_nil
      stat = PlayerComparisonStat.new(player_id: nil)

      assert_nil stat.player
    end

    def test_player_returns_player_object_when_player_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_info_response.to_json)

      stat = PlayerComparisonStat.new(player_id: 201_939)
      result = stat.player

      assert_instance_of Player, result
      assert_equal 201_939, result.id
    end

    private

    def player_info_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS
        JERSEY HEIGHT WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER]
      row = [201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson", "USA", 2009, 1, 7]
      {resultSets: [{headers: headers, rowSet: [row]}]}
    end
  end
end
