require_relative "../../test_helper"

module NBA
  class VideoEventsAssetEdgeCasesEmptyTest < Minitest::Test
    cover VideoEventsAsset

    def test_all_returns_empty_collection_when_response_nil
      client = Minitest::Mock.new
      client.expect(:get, nil, [String])

      result = VideoEventsAsset.all(game: "0022300001", client: client)

      assert_instance_of Collection, result
      assert_empty result
      client.verify
    end

    def test_all_returns_empty_collection_when_response_empty
      stub_request(:get, /videoeventsasset/).to_return(body: "")

      result = VideoEventsAsset.all(game: "0022300001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_result_sets_missing
      stub_request(:get, /videoeventsasset/).to_return(body: {}.to_json)

      result = VideoEventsAsset.all(game: "0022300001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_headers_nil
      stub_request(:get, /videoeventsasset/)
        .to_return(body: {resultSets: [{headers: nil, rowSet: [["data"]]}]}.to_json)

      result = VideoEventsAsset.all(game: "0022300001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_headers_key_missing
      stub_request(:get, /videoeventsasset/)
        .to_return(body: {resultSets: [{rowSet: []}]}.to_json)

      result = VideoEventsAsset.all(game: "0022300001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_row_set_missing
      stub_request(:get, /videoeventsasset/)
        .to_return(body: {resultSets: [{headers: []}]}.to_json)

      result = VideoEventsAsset.all(game: "0022300001")

      assert_instance_of Collection, result
      assert_empty result
    end
  end

  class VideoEventsAssetMissingKeysTest < Minitest::Test
    cover VideoEventsAsset

    def test_handles_missing_game_id_key
      response = {resultSets: [{headers: %w[GAME_EVENT_ID UUID VIDEO_AVAILABLE_FLAG],
                                rowSet: [[42, "abc123", 1]]}]}
      stub_request(:get, /videoeventsasset/).to_return(body: response.to_json)

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_nil asset.game_id
    end

    def test_handles_missing_game_event_id_key
      response = {resultSets: [{headers: %w[GAME_ID UUID VIDEO_AVAILABLE_FLAG],
                                rowSet: [["0022300001", "abc123", 1]]}]}
      stub_request(:get, /videoeventsasset/).to_return(body: response.to_json)

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_nil asset.game_event_id
    end

    def test_handles_missing_uuid_key
      response = {resultSets: [{headers: %w[GAME_ID GAME_EVENT_ID VIDEO_AVAILABLE_FLAG],
                                rowSet: [["0022300001", 42, 1]]}]}
      stub_request(:get, /videoeventsasset/).to_return(body: response.to_json)

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_nil asset.uuid
    end

    def test_handles_missing_video_available_flag_key
      response = {resultSets: [{headers: %w[GAME_ID GAME_EVENT_ID UUID VIDEO_URL],
                                rowSet: [["0022300001", 42, "abc123", "https://example.com"]]}]}
      stub_request(:get, /videoeventsasset/).to_return(body: response.to_json)

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_nil asset.video_available
    end

    def test_handles_missing_video_url_key
      response = {resultSets: [{headers: %w[GAME_ID GAME_EVENT_ID UUID VIDEO_AVAILABLE_FLAG],
                                rowSet: [["0022300001", 42, "abc123", 1]]}]}
      stub_request(:get, /videoeventsasset/).to_return(body: response.to_json)

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_nil asset.video_url
    end

    def test_handles_missing_description_key
      response = {resultSets: [{headers: %w[GAME_ID GAME_EVENT_ID UUID VIDEO_AVAILABLE_FLAG VIDEO_URL],
                                rowSet: [["0022300001", 42, "abc123", 1, "https://example.com"]]}]}
      stub_request(:get, /videoeventsasset/).to_return(body: response.to_json)

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_nil asset.video_description
    end

    def test_handles_missing_file_size_key
      response = {resultSets: [{headers: %w[GAME_ID GAME_EVENT_ID UUID],
                                rowSet: [["0022300001", 42, "abc123"]]}]}
      stub_request(:get, /videoeventsasset/).to_return(body: response.to_json)

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_nil asset.file_size
    end

    def test_handles_missing_aspect_ratio_key
      response = {resultSets: [{headers: %w[GAME_ID GAME_EVENT_ID UUID],
                                rowSet: [["0022300001", 42, "abc123"]]}]}
      stub_request(:get, /videoeventsasset/).to_return(body: response.to_json)

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_nil asset.aspect_ratio
    end

    def test_handles_missing_video_duration_key
      response = {resultSets: [{headers: %w[GAME_ID GAME_EVENT_ID UUID],
                                rowSet: [["0022300001", 42, "abc123"]]}]}
      stub_request(:get, /videoeventsasset/).to_return(body: response.to_json)

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_nil asset.video_duration
    end
  end
end
