require_relative "../test_helper"

module NBA
  class VideoEventsAssetAllTest < Minitest::Test
    cover VideoEventsAsset

    def test_all_returns_collection
      stub_video_events_asset_request

      assert_instance_of Collection, VideoEventsAsset.all(game: "0022300001")
    end

    def test_all_parses_game_info
      stub_video_events_asset_request

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_equal "0022300001", asset.game_id
      assert_equal 42, asset.game_event_id
      assert_equal "abc123", asset.uuid
    end

    def test_all_parses_video_info
      stub_video_events_asset_request

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_equal 1, asset.video_available
      assert_equal "https://videos.nba.com/example", asset.video_url
      assert_equal "Curry 3PT", asset.video_description
    end

    def test_all_parses_asset_info
      stub_video_events_asset_request

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_equal 1_024_000, asset.file_size
      assert_equal "16:9", asset.aspect_ratio
      assert_equal 15, asset.video_duration
    end

    def test_all_with_game_event_id
      stub_request(:get, /videoeventsasset.*GameEventID=42/)
        .to_return(body: video_events_asset_response.to_json)

      VideoEventsAsset.all(game: "0022300001", game_event_id: 42)

      assert_requested :get, /videoeventsasset.*GameEventID=42/
    end

    def test_all_default_game_event_id_is_zero
      stub_request(:get, /videoeventsasset.*GameEventID=0/)
        .to_return(body: video_events_asset_response.to_json)

      VideoEventsAsset.all(game: "0022300001")

      assert_requested :get, /videoeventsasset.*GameEventID=0/
    end

    def test_all_builds_correct_path
      stub_request(:get, /videoeventsasset.*GameID=0022300001/)
        .to_return(body: video_events_asset_response.to_json)

      VideoEventsAsset.all(game: "0022300001")

      assert_requested :get, /videoeventsasset.*GameID=0022300001/
    end

    def test_all_with_game_object
      game = Game.new(id: "0022300001")
      stub_request(:get, /videoeventsasset.*GameID=0022300001/)
        .to_return(body: video_events_asset_response.to_json)

      VideoEventsAsset.all(game: game)

      assert_requested :get, /videoeventsasset.*GameID=0022300001/
    end

    def test_all_selects_first_result_set_when_multiple_present
      response = {resultSets: [
        {headers: %w[GAME_ID GAME_EVENT_ID UUID VIDEO_AVAILABLE_FLAG VIDEO_URL DESCRIPTION FILE_SIZE ASPECT_RATIO VIDEO_DURATION],
         rowSet: [["0022300001", 42, "first", 1, "https://first.example", "First", 1000, "16:9", 10]]},
        {headers: %w[GAME_ID GAME_EVENT_ID UUID VIDEO_AVAILABLE_FLAG VIDEO_URL DESCRIPTION FILE_SIZE ASPECT_RATIO VIDEO_DURATION],
         rowSet: [["0022300002", 99, "second", 0, "https://second.example", "Second", 2000, "4:3", 20]]}
      ]}
      stub_request(:get, /videoeventsasset/).to_return(body: response.to_json)

      asset = VideoEventsAsset.all(game: "0022300001").first

      assert_equal "first", asset.uuid
    end

    private

    def stub_video_events_asset_request
      stub_request(:get, /videoeventsasset/).to_return(body: video_events_asset_response.to_json)
    end

    def video_events_asset_response
      {resultSets: [{name: "VideoEventsAsset",
                     headers: %w[GAME_ID GAME_EVENT_ID UUID VIDEO_AVAILABLE_FLAG VIDEO_URL DESCRIPTION FILE_SIZE ASPECT_RATIO
                       VIDEO_DURATION],
                     rowSet: [["0022300001", 42, "abc123", 1, "https://videos.nba.com/example", "Curry 3PT", 1_024_000, "16:9", 15]]}]}
    end
  end
end
