require_relative "../test_helper"

module NBA
  class LeadersFindEdgeCasesEmptyTest < Minitest::Test
    cover Leaders

    def test_find_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, Leaders.find(category: Leaders::PTS, client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_collection_when_no_result_set
      stub_request(:get, /leagueleaders/).to_return(body: {resultSet: nil}.to_json)

      assert_equal 0, Leaders.find(category: Leaders::PTS).size
    end

    def test_find_returns_empty_collection_when_result_set_key_missing
      stub_request(:get, /leagueleaders/).to_return(body: {}.to_json)

      assert_equal 0, Leaders.find(category: Leaders::PTS).size
    end

    def test_find_returns_empty_collection_when_no_headers
      stub_request(:get, /leagueleaders/).to_return(body: {resultSet: {headers: nil, rowSet: [[1, "Curry"]]}}.to_json)

      assert_equal 0, Leaders.find(category: Leaders::PTS).size
    end

    def test_find_returns_empty_collection_when_no_rows
      stub_request(:get, /leagueleaders/).to_return(body: {resultSet: {headers: %w[PLAYER_ID PLAYER], rowSet: nil}}.to_json)

      assert_equal 0, Leaders.find(category: Leaders::PTS).size
    end

    def test_find_returns_empty_when_headers_missing
      response = {resultSet: {rowSet: [[201_939, "Stephen Curry", 1, 30.0]]}}
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)

      assert_equal 0, Leaders.find(category: Leaders::PTS).size
    end

    def test_find_returns_empty_when_row_set_missing
      response = {resultSet: {headers: %w[PLAYER_ID PLAYER RANK PTS]}}
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)

      assert_equal 0, Leaders.find(category: Leaders::PTS).size
    end

    def test_find_handles_nil_category_value
      stub_leaders_with(pts_value: nil)

      assert_nil Leaders.find(category: Leaders::PTS).first.value
    end

    def test_find_encodes_season_type_with_spaces
      stub_request(:get, /leagueleaders.*SeasonType=Regular%20Season/).to_return(body: leaders_response.to_json)

      Leaders.find(category: Leaders::PTS, season_type: "Regular Season")

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_find_converts_value_to_float
      stub_leaders_with(pts_value: 32)

      leader = Leaders.find(category: Leaders::PTS).first

      assert_instance_of Float, leader.value
      assert_in_delta 32.0, leader.value
    end

    private

    def stub_leaders_with(pts_value:)
      response = leaders_response
      pts_index = response[:resultSet][:headers].index("PTS")
      response[:resultSet][:rowSet][0][pts_index] = pts_value
      stub_request(:get, /leagueleaders/).to_return(body: response.to_json)
    end

    def leaders_response
      {resultSet: {headers: %w[PLAYER_ID PLAYER TEAM_ID TEAM RANK PTS], rowSet: [[201_939, "Stephen Curry", Team::GSW, "GSW", 1, 32.4]]}}
    end
  end
end
