require_relative "../../test_helper"

module NBA
  class PlayerGameLogEdgeCasesTest < Minitest::Test
    cover PlayerGameLog

    def test_find_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, PlayerGameLog.find(player: 201_939, client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_collection_when_no_result_set
      stub_request(:get, /playergamelog/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, PlayerGameLog.find(player: 201_939).size
    end

    def test_find_returns_empty_collection_when_result_sets_empty
      stub_request(:get, /playergamelog/).to_return(body: {resultSets: []}.to_json)

      assert_equal 0, PlayerGameLog.find(player: 201_939).size
    end

    def test_find_returns_empty_collection_when_no_headers
      stub_request(:get, /playergamelog/).to_return(body: {resultSets: [{headers: nil, rowSet: []}]}.to_json)

      assert_equal 0, PlayerGameLog.find(player: 201_939).size
    end

    def test_find_returns_empty_collection_when_no_rows
      stub_request(:get, /playergamelog/).to_return(body: {resultSets: [{headers: %w[SEASON_ID], rowSet: nil}]}.to_json)

      assert_equal 0, PlayerGameLog.find(player: 201_939).size
    end

    def test_find_returns_empty_when_headers_nil_but_rows_exist
      response = {resultSets: [{headers: nil, rowSet: [["22024", 201_939, "001"]]}]}
      stub_request(:get, /playergamelog/).to_return(body: response.to_json)

      assert_equal 0, PlayerGameLog.find(player: 201_939).size
    end

    def test_find_uses_first_result_set_not_last
      first_set = {headers: %w[SEASON_ID Player_ID], rowSet: [["22024", 201_939]]}
      last_set = {headers: %w[SEASON_ID Player_ID], rowSet: [["22023", 201_940]]}
      response = {resultSets: [first_set, last_set]}
      stub_request(:get, /playergamelog/).to_return(body: response.to_json)

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal "22024", log.season_id
      assert_equal 201_939, log.player_id
    end

    def test_find_handles_missing_season_id
      response = {resultSets: [{headers: %w[Player_ID], rowSet: [[201_939]]}]}
      stub_request(:get, /playergamelog/).to_return(body: response.to_json)

      log = PlayerGameLog.find(player: 201_939).first

      assert_nil log.season_id
      assert_equal 201_939, log.player_id
    end
  end
end
