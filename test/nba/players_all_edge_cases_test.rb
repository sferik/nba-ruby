require_relative "../test_helper"

module NBA
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

    def test_all_handles_minimal_headers
      response = {resultSets: [{headers: %w[PERSON_ID DISPLAY_FIRST_LAST], rowSet: [[201_939, "Stephen Curry"]]}]}
      stub_request(:get, /commonallplayers/).to_return(body: response.to_json)

      player = Players.all.first

      assert_equal 201_939, player.id
      assert_equal "Stephen Curry", player.full_name
      refute player.is_active
    end

    def test_all_raises_when_person_id_missing
      response = {resultSets: [{headers: %w[DISPLAY_FIRST_LAST], rowSet: [["Stephen Curry"]]}]}
      stub_request(:get, /commonallplayers/).to_return(body: response.to_json)

      assert_raises(KeyError) { Players.all.first }
    end

    def test_all_raises_when_display_name_missing
      response = {resultSets: [{headers: %w[PERSON_ID], rowSet: [[201_939]]}]}
      stub_request(:get, /commonallplayers/).to_return(body: response.to_json)

      assert_raises(KeyError) { Players.all.first }
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
end
