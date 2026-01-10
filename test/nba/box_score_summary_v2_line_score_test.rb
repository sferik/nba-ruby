require_relative "../test_helper"
require_relative "box_score_summary_v2_test_helpers"

module NBA
  class BoxScoreSummaryV2LineScoreTest < Minitest::Test
    include BoxScoreSummaryV2TestHelpers

    cover BoxScoreSummaryV2

    def test_handles_malformed_line_score_headers
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "LineScore", headers: nil, rowSet: [visitor_line_row]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001").home_pts
    end

    def test_handles_line_score_with_single_row
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "LineScore", headers: line_headers, rowSet: [visitor_line_row]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_nil summary.home_pts
      assert_nil summary.visitor_pts
    end

    def test_handles_line_score_with_nil_row_set
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "LineScore", headers: line_headers, rowSet: nil}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001").home_pts
    end

    def test_line_score_home_visitor_order
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "LineScore", headers: line_headers, rowSet: [visitor_line_row, home_line_row]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal 115, summary.home_pts
      assert_equal 109, summary.visitor_pts
    end

    def test_handles_missing_line_score_headers_key
      response_hash = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "LineScore", rowSet: [visitor_line_row]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response_hash.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001").home_pts
    end

    def test_handles_missing_line_score_row_set_key
      response_hash = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "LineScore", headers: line_headers}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response_hash.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001").home_pts
    end

    def test_line_score_with_extra_rows_uses_first_two
      extra_row = [999_999, 10, 10, 10, 10, 0, 40]
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "LineScore", headers: line_headers, rowSet: [visitor_line_row, home_line_row, extra_row]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal 115, summary.home_pts
      assert_equal 109, summary.visitor_pts
    end

    def test_handles_nil_headers_with_valid_rows
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "LineScore", headers: nil, rowSet: [visitor_line_row, home_line_row]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001").home_pts
    end

    def test_handles_missing_result_sets_key
      stub_request(:get, /boxscoresummaryv2/).to_return(body: {}.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001")
    end

    def test_uses_first_row_when_multiple_game_summary_rows
      extra_row = ["2024-10-23", 1, "Scheduled", 999_999, 888_888, "2024-25", 0, "", 0, "0:00"]
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row, extra_row]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal Team::GSW, summary.home_team_id
    end
  end
end
