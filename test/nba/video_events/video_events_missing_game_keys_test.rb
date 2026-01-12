require_relative "video_events_missing_keys_helper"

module NBA
  class VideoEventsMissingGameKeysTest < Minitest::Test
    include VideoEventsMissingKeysHelper

    cover VideoEvents

    HEADERS = %w[GAME_ID GAME_EVENT_ID].freeze
    ROW = ["0022300001", 1].freeze

    def test_handles_missing_game_id_key
      stub_with_headers_except("GAME_ID", HEADERS, ROW)

      assert_nil VideoEvents.all(game: "0022300001").first.game_id
    end

    def test_handles_missing_game_event_id_key
      stub_with_headers_except("GAME_EVENT_ID", HEADERS, ROW)

      assert_nil VideoEvents.all(game: "0022300001").first.game_event_id
    end
  end
end
