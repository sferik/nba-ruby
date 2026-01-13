require_relative "../../test_helper"

module NBA
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
