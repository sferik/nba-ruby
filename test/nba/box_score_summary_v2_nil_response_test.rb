require_relative "../test_helper"
require_relative "box_score_summary_v2_test_helpers"

module NBA
  class BoxScoreSummaryV2NilResponseTest < Minitest::Test
    include BoxScoreSummaryV2TestHelpers

    cover BoxScoreSummaryV2

    def test_returns_nil_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]
      result = BoxScoreSummaryV2.find(game: "0022400001", client: mock_client)

      assert_nil result
    end

    def test_returns_nil_when_no_result_sets
      stub_request(:get, /boxscoresummaryv2/).to_return(body: {resultSets: nil}.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001")
    end

    def test_returns_nil_when_game_summary_not_found
      stub_request(:get, /boxscoresummaryv2/).to_return(body: {resultSets: [{name: "Other", headers: [], rowSet: []}]}.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001")
    end

    def test_returns_nil_when_game_summary_headers_missing
      stub_request(:get, /boxscoresummaryv2/).to_return(body: {resultSets: [{name: "GameSummary", rowSet: [[1]]}]}.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001")
    end

    def test_returns_nil_when_game_summary_row_missing
      stub_request(:get,
        /boxscoresummaryv2/).to_return(body: {resultSets: [{name: "GameSummary", headers: %w[GAME_ID], rowSet: []}]}.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001")
    end

    def test_returns_nil_when_game_summary_row_set_key_missing
      stub_request(:get,
        /boxscoresummaryv2/).to_return(body: {resultSets: [{name: "GameSummary", headers: game_headers}]}.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001")
    end

    def test_handles_missing_optional_result_sets
      stub_request(:get,
        /boxscoresummaryv2/).to_return(body: {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]}]}.to_json)
      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_nil summary.home_pts
      assert_empty summary.officials
    end

    def test_finds_game_summary_when_not_first
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}, {name: "GameSummary", headers: game_headers, rowSet: [game_row]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_equal "0022400001", BoxScoreSummaryV2.find(game: "0022400001").game_id
    end
  end
end
