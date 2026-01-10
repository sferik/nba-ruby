require_relative "box_score_summary_v3_edge_cases_helper"

module NBA
  class BoxScoreSummaryV3NilResponseTest < Minitest::Test
    include BoxScoreSummaryV3BaseTestHelpers

    cover BoxScoreSummaryV3

    def test_returns_nil_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_nil BoxScoreSummaryV3.find(game: "0022400001", client: mock_client)
    end

    def test_returns_nil_when_box_score_summary_key_missing
      stub_request(:get, /boxscoresummaryv3/).to_return(body: {}.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001")
    end

    def test_returns_nil_when_box_score_summary_is_nil
      stub_request(:get, /boxscoresummaryv3/).to_return(body: {boxScoreSummary: nil}.to_json)

      assert_nil BoxScoreSummaryV3.find(game: "0022400001")
    end
  end
end
