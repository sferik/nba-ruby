require_relative "../../test_helper"

module NBA
  class VideoStatusMissingGameKeysTest < Minitest::Test
    cover VideoStatus

    HEADERS = %w[GAME_ID GAME_DATE GAME_STATUS GAME_STATUS_TEXT].freeze
    ROW = ["0022300001", "2023-10-24", 3, "Final"].freeze

    def test_handles_missing_game_id_key
      stub_with_headers_except("GAME_ID")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.game_id
    end

    def test_handles_missing_game_date_key
      stub_with_headers_except("GAME_DATE")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.game_date
    end

    def test_handles_missing_game_status_key
      stub_with_headers_except("GAME_STATUS")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.game_status
    end

    def test_handles_missing_game_status_text_key
      stub_with_headers_except("GAME_STATUS_TEXT")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.game_status_text
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{name: "VideoStatus", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videostatus/).to_return(body: response.to_json)
    end
  end
end
