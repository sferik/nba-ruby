require_relative "../../test_helper"
require_relative "win_probability_test_helpers"

module NBA
  class WinProbabilityMissingKeysPlayTest < Minitest::Test
    include WinProbabilityTestHelpers

    cover WinProbability

    def test_handles_missing_home_description_key
      stub_request_without("HOME_DESCRIPTION")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.home_description
    end

    def test_handles_missing_neutral_description_key
      stub_request_without("NEUTRAL_DESCRIPTION")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.neutral_description
    end

    def test_handles_missing_visitor_description_key
      stub_request_without("VISITOR_DESCRIPTION")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.visitor_description
    end

    private

    def stub_request_without(excluded_key)
      headers = win_prob_headers.reject { |h| h.eql?(excluded_key) }
      row = build_row_without(excluded_key)
      response = build_win_prob_response(headers, row)

      stub_request(:get, /winprobabilitypbp.*GameID=0022400001/)
        .to_return(body: response.to_json)
    end
  end
end
