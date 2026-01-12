require_relative "../../test_helper"
require_relative "win_probability_test_helpers"

module NBA
  class WinProbabilityNilValuesPlayTest < Minitest::Test
    include WinProbabilityTestHelpers

    cover WinProbability

    def test_handles_nil_neutral_description_value
      stub_request_with_nil("NEUTRAL_DESCRIPTION")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.neutral_description
    end

    def test_handles_nil_visitor_description_value
      stub_request_with_nil("VISITOR_DESCRIPTION")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.visitor_description
    end

    def test_handles_nil_home_description_value
      stub_request_with_nil("HOME_DESCRIPTION")
      point = WinProbability.find(game: "0022400001").first

      assert_nil point.home_description
    end

    private

    def stub_request_with_nil(key_with_nil_value)
      row = build_row_with_nil(key_with_nil_value)
      response = build_win_prob_response(win_prob_headers, row)

      stub_request(:get, /winprobabilitypbp.*GameID=0022400001/)
        .to_return(body: response.to_json)
    end
  end
end
