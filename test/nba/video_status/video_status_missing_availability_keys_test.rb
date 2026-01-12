require_relative "../../test_helper"

module NBA
  class VideoStatusMissingAvailabilityKeysTest < Minitest::Test
    cover VideoStatus

    HEADERS = %w[IS_AVAILABLE PT_XYZ_AVAILABLE].freeze
    ROW = [1, 1].freeze

    def test_handles_missing_is_available_key
      stub_with_headers_except("IS_AVAILABLE")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.is_available
    end

    def test_handles_missing_pt_xyz_available_key
      stub_with_headers_except("PT_XYZ_AVAILABLE")

      assert_nil VideoStatus.all(game_date: "2023-10-24").first.pt_xyz_available
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
