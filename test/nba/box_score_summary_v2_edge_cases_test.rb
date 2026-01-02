require_relative "../test_helper"

module NBA
  module BoxScoreSummaryV2TestHelpers
    private

    def game_headers
      %w[GAME_DATE_EST GAME_STATUS_ID GAME_STATUS_TEXT HOME_TEAM_ID VISITOR_TEAM_ID SEASON LIVE_PERIOD LIVE_PC_TIME ATTENDANCE GAME_TIME]
    end

    def game_row
      ["2024-10-22", 3, "Final", Team::GSW, 1_610_612_747, "2024-25", 4, "0:00", 18_064, "2:18"]
    end

    def visitor_line_row
      [1_610_612_747, 25, 28, 30, 26, 0, 109]
    end

    def home_line_row
      [Team::GSW, 28, 30, 32, 25, 0, 115]
    end

    def line_headers
      %w[TEAM_ID PTS_QTR1 PTS_QTR2 PTS_QTR3 PTS_QTR4 PTS_OT1 PTS]
    end
  end

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
