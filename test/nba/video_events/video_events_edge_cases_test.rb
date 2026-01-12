require_relative "../../test_helper"

module NBA
  class VideoEventsEdgeCasesTest < Minitest::Test
    cover VideoEvents

    def test_all_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, VideoEvents.all(game: "0022300001", client: mock_client).size
      mock_client.verify
    end

    def test_all_returns_empty_collection_when_no_result_sets
      stub_request(:get, /videoevents/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, VideoEvents.all(game: "0022300001").size
    end

    def test_all_returns_empty_collection_when_result_sets_key_missing
      stub_request(:get, /videoevents/).to_return(body: {}.to_json)

      assert_equal 0, VideoEvents.all(game: "0022300001").size
    end

    def test_all_returns_empty_collection_when_no_headers
      response = {resultSets: [{headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /videoevents/).to_return(body: response.to_json)

      assert_equal 0, VideoEvents.all(game: "0022300001").size
    end

    def test_all_returns_empty_collection_when_headers_key_missing
      response = {resultSets: [{rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /videoevents/).to_return(body: response.to_json)

      assert_equal 0, VideoEvents.all(game: "0022300001").size
    end

    def test_all_returns_empty_collection_when_no_rows
      response = {resultSets: [{headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /videoevents/).to_return(body: response.to_json)

      assert_equal 0, VideoEvents.all(game: "0022300001").size
    end

    def test_all_returns_empty_collection_when_rowset_key_missing
      response = {resultSets: [{headers: %w[GAME_ID]}]}
      stub_request(:get, /videoevents/).to_return(body: response.to_json)

      assert_equal 0, VideoEvents.all(game: "0022300001").size
    end

    def test_all_uses_first_result_set
      first_set = {headers: %w[GAME_ID UUID], rowSet: [%w[0022300001 abc123]]}
      second_set = {headers: %w[GAME_ID UUID], rowSet: [%w[0022300002 def456]]}
      response = {resultSets: [first_set, second_set]}
      stub_request(:get, /videoevents/).to_return(body: response.to_json)

      event = VideoEvents.all(game: "0022300001").first

      assert_equal "0022300001", event.game_id
      assert_equal "abc123", event.uuid
    end

    def test_all_handles_missing_game_id_header
      response = {resultSets: [{headers: %w[UUID], rowSet: [["abc123"]]}]}
      stub_request(:get, /videoevents/).to_return(body: response.to_json)

      event = VideoEvents.all(game: "0022300001").first

      assert_nil event.game_id
      assert_equal "abc123", event.uuid
    end

    def test_all_handles_empty_result_sets_array
      stub_request(:get, /videoevents/).to_return(body: {resultSets: []}.to_json)

      assert_equal 0, VideoEvents.all(game: "0022300001").size
    end
  end
end
