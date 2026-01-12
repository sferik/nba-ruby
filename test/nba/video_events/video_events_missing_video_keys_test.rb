require_relative "video_events_missing_keys_helper"

module NBA
  class VideoEventsMissingVideoKeysTest < Minitest::Test
    include VideoEventsMissingKeysHelper

    cover VideoEvents

    HEADERS = %w[VIDEO_AVAILABLE_FLAG VIDEO_URL DESCRIPTION CATEGORY UUID TITLE].freeze
    ROW = [1, "https://videos.nba.com/test.mp4", "Test description", "Made Shot", "abc123", "Test Title"].freeze

    def test_handles_missing_video_available_flag_key
      stub_with_headers_except("VIDEO_AVAILABLE_FLAG", HEADERS, ROW)

      assert_nil VideoEvents.all(game: "0022300001").first.video_available
    end

    def test_handles_missing_video_url_key
      stub_with_headers_except("VIDEO_URL", HEADERS, ROW)

      assert_nil VideoEvents.all(game: "0022300001").first.video_url
    end

    def test_handles_missing_description_key
      stub_with_headers_except("DESCRIPTION", HEADERS, ROW)

      assert_nil VideoEvents.all(game: "0022300001").first.video_description
    end

    def test_handles_missing_category_key
      stub_with_headers_except("CATEGORY", HEADERS, ROW)

      assert_nil VideoEvents.all(game: "0022300001").first.video_category
    end

    def test_handles_missing_uuid_key
      stub_with_headers_except("UUID", HEADERS, ROW)

      assert_nil VideoEvents.all(game: "0022300001").first.uuid
    end

    def test_handles_missing_title_key
      stub_with_headers_except("TITLE", HEADERS, ROW)

      assert_nil VideoEvents.all(game: "0022300001").first.title
    end
  end
end
