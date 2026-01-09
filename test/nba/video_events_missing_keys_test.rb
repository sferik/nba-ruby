require_relative "../test_helper"

module NBA
  class VideoEventsMissingGameKeysTest < Minitest::Test
    cover VideoEvents

    HEADERS = %w[GAME_ID GAME_EVENT_ID].freeze
    ROW = ["0022300001", 1].freeze

    def test_handles_missing_game_id_key
      stub_with_headers_except("GAME_ID")

      assert_nil VideoEvents.all(game: "0022300001").first.game_id
    end

    def test_handles_missing_game_event_id_key
      stub_with_headers_except("GAME_EVENT_ID")

      assert_nil VideoEvents.all(game: "0022300001").first.game_event_id
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{headers: headers, rowSet: [row]}]}
      stub_request(:get, /videoevents/).to_return(body: response.to_json)
    end
  end

  class VideoEventsMissingVideoKeysTest < Minitest::Test
    cover VideoEvents

    HEADERS = %w[VIDEO_AVAILABLE_FLAG VIDEO_URL DESCRIPTION CATEGORY UUID TITLE].freeze
    ROW = [1, "https://videos.nba.com/test.mp4", "Test description", "Made Shot", "abc123", "Test Title"].freeze

    def test_handles_missing_video_available_flag_key
      stub_with_headers_except("VIDEO_AVAILABLE_FLAG")

      assert_nil VideoEvents.all(game: "0022300001").first.video_available
    end

    def test_handles_missing_video_url_key
      stub_with_headers_except("VIDEO_URL")

      assert_nil VideoEvents.all(game: "0022300001").first.video_url
    end

    def test_handles_missing_description_key
      stub_with_headers_except("DESCRIPTION")

      assert_nil VideoEvents.all(game: "0022300001").first.video_description
    end

    def test_handles_missing_category_key
      stub_with_headers_except("CATEGORY")

      assert_nil VideoEvents.all(game: "0022300001").first.video_category
    end

    def test_handles_missing_uuid_key
      stub_with_headers_except("UUID")

      assert_nil VideoEvents.all(game: "0022300001").first.uuid
    end

    def test_handles_missing_title_key
      stub_with_headers_except("TITLE")

      assert_nil VideoEvents.all(game: "0022300001").first.title
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{headers: headers, rowSet: [row]}]}
      stub_request(:get, /videoevents/).to_return(body: response.to_json)
    end
  end
end
