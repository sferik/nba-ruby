require_relative "../test_helper"

module NBA
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
end
