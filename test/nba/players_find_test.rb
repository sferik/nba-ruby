require_relative "../test_helper"

module NBA
  class PlayersFindTest < Minitest::Test
    cover Players

    def test_find_returns_player_by_id
      stub_player_info_request

      player = Players.find(201_939)

      assert_instance_of Player, player
      assert_equal 201_939, player.id
      assert_equal "Stephen Curry", player.full_name
    end

    def test_find_returns_player_by_player_object
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/).to_return(body: player_info_response.to_json)

      player = Players.find(Player.new(id: 201_939))

      assert_equal 201_939, player.id
    end

    def test_find_with_integer_id
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/).to_return(body: player_info_response.to_json)

      player = Players.find(201_939)

      assert_equal 201_939, player.id
    end

    def test_find_parses_player_identity
      stub_player_info_request
      player = Players.find(201_939)

      assert_equal "Stephen Curry", player.full_name
      assert_equal "Stephen", player.first_name
      assert_equal "Curry", player.last_name
    end

    def test_find_parses_player_physical
      stub_player_info_request
      player = Players.find(201_939)

      assert_equal 30, player.jersey_number
      assert_equal "6-2", player.height
      assert_equal 185, player.weight
    end

    def test_find_parses_player_background
      stub_player_info_request
      player = Players.find(201_939)

      assert_equal "Davidson", player.college
      assert_equal "USA", player.country
      assert player.is_active
    end

    def test_find_parses_player_draft_info
      stub_player_info_request
      player = Players.find(201_939)

      assert_equal 2009, player.draft_year
      assert_equal 1, player.draft_round
      assert_equal 7, player.draft_number
    end

    def test_find_with_minimal_headers
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

    def test_find_raises_when_person_id_missing
      response = {resultSets: [{headers: %w[DISPLAY_FIRST_LAST],
                                rowSet: [["Stephen Curry"]]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_raises(KeyError) { Players.find(201_939) }
    end

    def test_find_raises_when_display_name_missing
      response = {resultSets: [{headers: %w[PERSON_ID],
                                rowSet: [[201_939]]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_raises(KeyError) { Players.find(201_939) }
    end

    def test_find_handles_numeric_active_roster_status
      response = {resultSets: [{headers: %w[PERSON_ID DISPLAY_FIRST_LAST ROSTERSTATUS],
                                rowSet: [[201_939, "Stephen Curry", 1]]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert Players.find(201_939).is_active
    end

    def test_find_handles_numeric_inactive_roster_status
      response = {resultSets: [{headers: %w[PERSON_ID DISPLAY_FIRST_LAST ROSTERSTATUS],
                                rowSet: [[201_939, "Stephen Curry", 0]]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      refute Players.find(201_939).is_active
    end

    private

    def stub_player_info_request
      stub_request(:get, /commonplayerinfo/).to_return(body: player_info_response.to_json)
    end

    def player_info_response
      {resultSets: [{headers: player_info_headers, rowSet: [player_info_row]}]}
    end

    def player_info_headers
      %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND
        DRAFT_NUMBER]
    end

    def player_info_row
      [201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson", "USA", 2009, 1, 7]
    end
  end
end
