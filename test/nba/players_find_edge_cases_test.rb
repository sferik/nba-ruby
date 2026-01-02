require_relative "../test_helper"

module NBA
  class PlayersFindEdgeCasesTest < Minitest::Test
    cover Players

    def test_find_handles_empty_jersey
      stub_player_info_with(jersey: "")

      assert_nil Players.find(201_939).jersey_number
    end

    def test_find_handles_non_numeric_jersey
      stub_player_info_with(jersey: "N/A")

      assert_nil Players.find(201_939).jersey_number
    end

    def test_find_handles_whitespace_jersey
      stub_player_info_with(jersey: "   ")

      assert_nil Players.find(201_939).jersey_number
    end

    def test_find_handles_integer_weight_directly
      stub_player_info_with(weight: 200)

      assert_equal 200, Players.find(201_939).weight
    end

    def test_find_handles_nil_weight
      stub_player_info_with(weight: nil)

      assert_nil Players.find(201_939).weight
    end

    def test_find_parses_weight_from_string
      stub_player_info_with(weight: "200")

      assert_equal 200, Players.find(201_939).weight
    end

    def test_find_parses_draft_year_from_string
      stub_player_info_with(draft_year: "2010")

      assert_equal 2010, Players.find(201_939).draft_year
    end

    def test_find_parses_draft_round_from_string
      stub_player_info_with(draft_round: "2")

      assert_equal 2, Players.find(201_939).draft_round
    end

    def test_find_parses_draft_number_from_string
      stub_player_info_with(draft_number: "15")

      assert_equal 15, Players.find(201_939).draft_number
    end

    def test_find_handles_non_numeric_weight
      stub_player_info_with(weight: "N/A")

      assert_nil Players.find(201_939).weight
    end

    def test_find_handles_undrafted_year
      stub_player_info_with(draft_year: "Undrafted")

      assert_nil Players.find(201_939).draft_year
    end

    def test_find_handles_undrafted_round
      stub_player_info_with(draft_round: "Undrafted")

      assert_nil Players.find(201_939).draft_round
    end

    def test_find_handles_undrafted_number
      stub_player_info_with(draft_number: "Undrafted")

      assert_nil Players.find(201_939).draft_number
    end

    def test_find_handles_missing_optional_fields
      stub_request(:get, /commonplayerinfo/).to_return(body: minimal_player_response.to_json)

      player = Players.find(201_939)

      assert_equal 201_939, player.id
      assert_nil player.jersey_number
      assert_nil player.weight
      assert_nil player.draft_year
    end

    def test_find_handles_truly_minimal_headers
      response = {resultSets: [{headers: %w[PERSON_ID DISPLAY_FIRST_LAST],
                                rowSet: [[201_939, "Stephen Curry"]]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      player = Players.find(201_939)

      assert_equal 201_939, player.id
      assert_equal "Stephen Curry", player.full_name
      assert_nil player.first_name
      assert_nil player.last_name
      refute player.is_active
    end

    private

    def minimal_player_response
      {resultSets: [{headers: %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS],
                     rowSet: [[201_939, "Stephen Curry", "Stephen", "Curry", "Active"]]}]}
    end

    def stub_player_info_with(overrides)
      response = player_info_response
      field_map = {jersey: "JERSEY", weight: "WEIGHT", draft_year: "DRAFT_YEAR", draft_round: "DRAFT_ROUND", draft_number: "DRAFT_NUMBER"}
      overrides.each do |key, value|
        idx = response[:resultSets][0][:headers].index(field_map.fetch(key))
        response[:resultSets][0][:rowSet][0][idx] = value
      end
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)
    end

    def player_info_response
      {resultSets: [{headers: player_info_headers,
                     rowSet: [[201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson", "USA", 2009, 1, 7]]}]}
    end

    def player_info_headers
      %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND
        DRAFT_NUMBER]
    end
  end
end
