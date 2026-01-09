require_relative "../test_helper"

module NBA
  class VideoEventsAllTest < Minitest::Test
    cover VideoEvents

    def test_all_returns_collection
      stub_video_events_request

      assert_instance_of Collection, VideoEvents.all(game: "0022300001")
    end

    def test_all_uses_game_id_parameter
      stub_video_events_request

      VideoEvents.all(game: "0022300001")

      assert_requested :get, /videoevents.*GameID=0022300001/
    end

    def test_all_accepts_game_object
      stub_video_events_request
      game = Game.new(id: "0022300001")

      VideoEvents.all(game: game)

      assert_requested :get, /videoevents.*GameID=0022300001/
    end

    def test_all_with_custom_game_event_id
      stub_video_events_request

      VideoEvents.all(game: "0022300001", game_event_id: 5)

      assert_requested :get, /videoevents.*GameEventID=5/
    end

    def test_all_uses_default_game_event_id
      stub_video_events_request

      VideoEvents.all(game: "0022300001")

      assert_requested :get, /videoevents.*GameEventID=0/
    end

    def test_all_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, video_events_response.to_json, [String]

      result = VideoEvents.all(game: "0022300001", client: mock_client)

      assert_instance_of Collection, result
      mock_client.verify
    end

    def test_all_parses_game_id
      stub_video_events_request

      event = VideoEvents.all(game: "0022300001").first

      assert_equal "0022300001", event.game_id
    end

    def test_all_parses_game_event_id
      stub_video_events_request

      event = VideoEvents.all(game: "0022300001").first

      assert_equal 1, event.game_event_id
    end

    def test_all_parses_video_available
      stub_video_events_request

      event = VideoEvents.all(game: "0022300001").first

      assert_equal 1, event.video_available
    end

    def test_all_parses_video_url
      stub_video_events_request

      event = VideoEvents.all(game: "0022300001").first

      assert_equal "https://videos.nba.com/test.mp4", event.video_url
    end

    def test_all_parses_video_description
      stub_video_events_request

      event = VideoEvents.all(game: "0022300001").first

      assert_equal "Curry makes 3-pt jump shot", event.video_description
    end

    def test_all_parses_video_category
      stub_video_events_request

      event = VideoEvents.all(game: "0022300001").first

      assert_equal "Made Shot", event.video_category
    end

    def test_all_parses_uuid
      stub_video_events_request

      event = VideoEvents.all(game: "0022300001").first

      assert_equal "abc123", event.uuid
    end

    def test_all_parses_title
      stub_video_events_request

      event = VideoEvents.all(game: "0022300001").first

      assert_equal "Curry 3PT", event.title
    end

    private

    def stub_video_events_request
      stub_request(:get, /videoevents/).to_return(body: video_events_response.to_json)
    end

    def video_events_response
      {resultSets: [{headers: video_events_headers, rowSet: [video_events_row]}]}
    end

    def video_events_headers
      %w[GAME_ID GAME_EVENT_ID VIDEO_AVAILABLE_FLAG VIDEO_URL DESCRIPTION CATEGORY UUID TITLE]
    end

    def video_events_row
      ["0022300001", 1, 1, "https://videos.nba.com/test.mp4",
        "Curry makes 3-pt jump shot", "Made Shot", "abc123", "Curry 3PT"]
    end
  end
end
