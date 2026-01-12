require_relative "../../test_helper"
require_relative "win_probability_test_helpers"

module NBA
  class WinProbabilityAttributeKeysPlayTest < Minitest::Test
    include WinProbabilityTestHelpers

    cover WinProbability

    def test_uses_correct_home_description_key
      response = build_response_with_values(
        "HOME_DESCRIPTION" => "home value",
        "NEUTRAL_DESCRIPTION" => "neutral value",
        "VISITOR_DESCRIPTION" => "visitor value"
      )
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal "home value", point.home_description
    end

    def test_uses_correct_neutral_description_key
      response = build_response_with_values(
        "HOME_DESCRIPTION" => "home value",
        "NEUTRAL_DESCRIPTION" => "neutral value",
        "VISITOR_DESCRIPTION" => "visitor value"
      )
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal "neutral value", point.neutral_description
    end

    def test_uses_correct_visitor_description_key
      response = build_response_with_values(
        "HOME_DESCRIPTION" => "home value",
        "NEUTRAL_DESCRIPTION" => "neutral value",
        "VISITOR_DESCRIPTION" => "visitor value"
      )
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)
      point = WinProbability.find(game: "0022400001").first

      assert_equal "visitor value", point.visitor_description
    end
  end
end
