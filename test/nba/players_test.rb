require_relative "../test_helper"

module NBA
  class PlayersAllTest < Minitest::Test
    cover Players

    def test_all_returns_collection_of_players
      stub_players_request

      players = Players.all

      assert_instance_of Collection, players
    end

    def test_all_parses_player_id_and_name
      stub_players_request

      curry = Players.all.first

      assert_equal 201_939, curry.id
      assert_equal "Stephen Curry", curry.full_name
      assert_equal "Stephen", curry.first_name
      assert_equal "Curry", curry.last_name
    end

    def test_all_parses_active_status
      stub_players_request

      curry = Players.all.first

      assert curry.is_active
    end

    def test_all_with_custom_season
      stub_request(:get, /commonallplayers.*Season=2023-24/).to_return(body: players_response.to_json)

      Players.all(season: 2023)

      assert_requested :get, /commonallplayers.*Season=2023-24/
    end

    def test_all_with_only_current_false
      stub_request(:get, /commonallplayers.*IsOnlyCurrentSeason=0/).to_return(body: players_response.to_json)

      Players.all(only_current: false)

      assert_requested :get, /commonallplayers.*IsOnlyCurrentSeason=0/
    end

    def test_all_default_only_current_is_true
      stub_request(:get, /commonallplayers.*IsOnlyCurrentSeason=1/).to_return(body: players_response.to_json)

      Players.all

      assert_requested :get, /commonallplayers.*IsOnlyCurrentSeason=1/
    end

    def test_all_only_current_true_sets_flag
      stub_request(:get, /commonallplayers.*IsOnlyCurrentSeason=1/).to_return(body: players_response.to_json)

      Players.all(only_current: true)

      assert_requested :get, /commonallplayers.*IsOnlyCurrentSeason=1/
    end

    private

    def stub_players_request
      stub_request(:get, /commonallplayers/).to_return(body: players_response.to_json)
    end

    def player_headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS]

    def players_response
      {resultSets: [{headers: player_headers, rowSet: [[201_939, "Stephen Curry", "Stephen", "Curry", "Active"]]}]}
    end
  end

  class PlayersAllEdgeCasesTest < Minitest::Test
    cover Players

    def test_all_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, Players.all(client: mock_client).size
      mock_client.verify
    end

    def test_all_returns_empty_collection_when_no_result_sets
      stub_request(:get, /commonallplayers/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, Players.all.size
    end

    def test_all_returns_empty_collection_when_no_headers
      stub_request(:get, /commonallplayers/).to_return(body: {resultSets: [{headers: nil, rowSet: [["data"]]}]}.to_json)

      assert_equal 0, Players.all.size
    end

    def test_all_returns_empty_collection_when_no_rows
      stub_request(:get, /commonallplayers/).to_return(body: {resultSets: [{headers: %w[PERSON_ID], rowSet: nil}]}.to_json)

      assert_equal 0, Players.all.size
    end

    def test_all_handles_nil_first_name_with_full_name
      stub_players_with(first_name: nil, last_name: nil)

      player = Players.all.first

      assert_equal "Stephen", player.first_name
      assert_equal "Curry", player.last_name
    end

    def test_all_handles_nil_full_name
      stub_players_with(full_name: nil, first_name: nil, last_name: nil)

      player = Players.all.first

      assert_nil player.first_name
      assert_nil player.last_name
    end

    def test_all_handles_nil_roster_status
      stub_players_with(roster_status: nil)

      refute Players.all.first.is_active
    end

    def test_all_handles_inactive_roster_status
      stub_players_with(roster_status: "Inactive")

      refute Players.all.first.is_active
    end

    def test_all_handles_numeric_active_roster_status
      stub_players_with(roster_status: 1)

      assert Players.all.first.is_active
    end

    def test_all_handles_numeric_inactive_roster_status
      stub_players_with(roster_status: 0)

      refute Players.all.first.is_active
    end

    def test_all_handles_float_active_roster_status
      stub_players_with(roster_status: 1.0)

      assert Players.all.first.is_active
    end

    def test_all_uses_first_result_set
      response = {resultSets: [first_result_set, second_result_set]}
      stub_request(:get, /commonallplayers/).to_return(body: response.to_json)

      assert_equal "Stephen Curry", Players.all.first.full_name
    end

    private

    def first_result_set
      {headers: player_headers, rowSet: [[201_939, "Stephen Curry", "Stephen", "Curry", "Active"]]}
    end

    def second_result_set
      {headers: player_headers, rowSet: [[1, "Wrong Player", "Wrong", "Player", "Inactive"]]}
    end

    def stub_players_with(overrides)
      row = [201_939, overrides.fetch(:full_name, "Stephen Curry"), overrides.fetch(:first_name, "Stephen"),
        overrides.fetch(:last_name, "Curry"), overrides.fetch(:roster_status, "Active")]
      stub_request(:get, /commonallplayers/).to_return(body: {resultSets: [{headers: player_headers, rowSet: [row]}]}.to_json)
    end

    def player_headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS]
  end

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

  class PlayersFindNilResponseTest < Minitest::Test
    cover Players

    def test_find_returns_nil_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_nil Players.find(201_939, client: mock_client)
      mock_client.verify
    end

    def test_find_returns_nil_when_no_result_sets
      stub_request(:get, /commonplayerinfo/).to_return(body: {resultSets: nil}.to_json)

      assert_nil Players.find(201_939)
    end

    def test_find_returns_nil_when_no_row
      stub_request(:get, /commonplayerinfo/).to_return(body: {resultSets: [{headers: ["PERSON_ID"], rowSet: []}]}.to_json)

      assert_nil Players.find(201_939)
    end

    def test_find_returns_nil_when_rowset_key_missing
      stub_request(:get, /commonplayerinfo/).to_return(body: {resultSets: [{headers: ["PERSON_ID"]}]}.to_json)

      assert_nil Players.find(201_939)
    end

    def test_find_returns_nil_when_no_headers
      stub_request(:get, /commonplayerinfo/).to_return(body: {resultSets: [{headers: nil, rowSet: [[201_939]]}]}.to_json)

      assert_nil Players.find(201_939)
    end

    def test_find_uses_first_result_set
      stub_request(:get, /commonplayerinfo/).to_return(body: multi_result_response.to_json)

      assert_equal "Stephen Curry", Players.find(201_939).full_name
    end

    def test_find_uses_first_row
      stub_request(:get, /commonplayerinfo/).to_return(body: multi_row_response.to_json)

      assert_equal "Stephen Curry", Players.find(201_939).full_name
    end

    def test_find_parses_inactive_player
      stub_request(:get, /commonplayerinfo/).to_return(body: inactive_player_response.to_json)

      refute Players.find(201_939).is_active
    end

    private

    def player_info_headers
      %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND
        DRAFT_NUMBER]
    end

    def curry_row
      [201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson", "USA", 2009, 1, 7]
    end

    def wrong_row
      [1, "Wrong Player", "Wrong", "Player", "Inactive", "99", "5-0", 100, "None", "None", 0, 0, 0]
    end

    def multi_result_response
      {resultSets: [{headers: player_info_headers, rowSet: [curry_row]}, {headers: player_info_headers, rowSet: [wrong_row]}]}
    end

    def multi_row_response
      {resultSets: [{headers: player_info_headers, rowSet: [curry_row, wrong_row]}]}
    end

    def inactive_player_response
      {resultSets: [{headers: player_info_headers, rowSet: [[201_939, "Michael Jordan", "Michael", "Jordan", "Inactive",
        "23", "6-6", 195, "UNC", "USA", 1984, 1, 3]]}]}
    end
  end

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

    private

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
