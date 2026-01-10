require_relative "../test_helper"
require_relative "box_score_summary_v2_test_helpers"

module NBA
  class BoxScoreSummaryV2AuxiliaryTest < Minitest::Test
    include BoxScoreSummaryV2TestHelpers

    cover BoxScoreSummaryV2

    def test_handles_malformed_officials_headers
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "Officials", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_empty BoxScoreSummaryV2.find(game: "0022400001").officials
    end

    def test_handles_officials_without_name_columns
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "Officials", headers: %w[OFFICIAL_ID], rowSet: [[1]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_empty BoxScoreSummaryV2.find(game: "0022400001").officials
    end

    def test_handles_malformed_other_stats
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "OtherStats", headers: nil, rowSet: []}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001").arena
    end

    def test_officials_with_valid_data
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "Officials", headers: %w[OFFICIAL_ID FIRST_NAME LAST_NAME], rowSet: [[1, "John", "Doe"], [2, "Jane", "Smith"]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal ["John Doe", "Jane Smith"], summary.officials
    end

    def test_officials_with_nil_row_set
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "Officials", headers: %w[OFFICIAL_ID], rowSet: nil}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_empty BoxScoreSummaryV2.find(game: "0022400001").officials
    end

    def test_other_stats_with_nil_row_set
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "OtherStats", headers: %w[LEAD_CHANGES TIMES_TIED ARENA], rowSet: nil}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001").arena
    end

    def test_other_stats_with_empty_row_set
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "OtherStats", headers: %w[LEAD_CHANGES TIMES_TIED ARENA], rowSet: []}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001").arena
    end

    def test_handles_missing_officials_headers_key
      response_hash = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "Officials", rowSet: [[1]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response_hash.to_json)

      assert_empty BoxScoreSummaryV2.find(game: "0022400001").officials
    end

    def test_handles_missing_officials_row_set_key
      response_hash = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "Officials", headers: %w[FIRST_NAME LAST_NAME]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response_hash.to_json)

      assert_empty BoxScoreSummaryV2.find(game: "0022400001").officials
    end

    def test_handles_missing_other_stats_headers_key
      response_hash = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "OtherStats", rowSet: [[5, 3, "Chase Center"]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response_hash.to_json)

      assert_nil BoxScoreSummaryV2.find(game: "0022400001").arena
    end

    def test_officials_returns_empty_when_only_first_name_column
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "Officials", headers: %w[OFFICIAL_ID FIRST_NAME], rowSet: [[1, "John"]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_empty BoxScoreSummaryV2.find(game: "0022400001").officials
    end

    def test_officials_returns_empty_when_only_last_name_column
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "Officials", headers: %w[OFFICIAL_ID LAST_NAME], rowSet: [[1, "Doe"]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      assert_empty BoxScoreSummaryV2.find(game: "0022400001").officials
    end

    def test_other_stats_uses_first_row_when_multiple_rows
      response = {resultSets: [{name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "OtherStats", headers: %w[LEAD_CHANGES TIMES_TIED ARENA], rowSet: [[5, 3, "Chase Center"], [10, 8, "Wrong Arena"]]}]}
      stub_request(:get, /boxscoresummaryv2/).to_return(body: response.to_json)

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal "Chase Center", summary.arena
      assert_equal 5, summary.lead_changes
    end
  end
end
