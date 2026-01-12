require_relative "../../test_helper"

module NBA
  class BoxScoreSummaryV2GameAttributeMappingTest < Minitest::Test
    cover BoxScoreSummaryV2

    def test_maps_game_id
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal "0022400001", summary.game_id
    end

    def test_maps_game_date
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal "2024-10-22", summary.game_date
    end

    def test_maps_game_status_id
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal 3, summary.game_status_id
    end

    def test_maps_game_status_text
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal "Final", summary.game_status_text
    end

    def test_maps_home_team_id
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal Team::GSW, summary.home_team_id
    end

    def test_maps_visitor_team_id
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal 1_610_612_747, summary.visitor_team_id
    end

    def test_maps_season
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal "2024-25", summary.season
    end

    def test_maps_live_period
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal 4, summary.live_period
    end

    def test_maps_live_pc_time
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal "0:00", summary.live_pc_time
    end

    def test_maps_attendance
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal 18_064, summary.attendance
    end

    def test_maps_game_time
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal "2:18", summary.game_time
    end

    private

    def stub_summary_request
      stub_request(:get, /boxscoresummaryv2/).to_return(body: summary_response.to_json)
    end

    def summary_response
      {resultSets: [
        {name: "GameSummary", headers: game_headers, rowSet: [game_row]},
        {name: "LineScore", headers: line_headers, rowSet: [visitor_line_row, home_line_row]},
        {name: "Officials", headers: official_headers, rowSet: official_rows},
        {name: "OtherStats", headers: other_headers, rowSet: [other_row]}
      ]}
    end

    def game_headers
      %w[GAME_DATE_EST GAME_STATUS_ID GAME_STATUS_TEXT HOME_TEAM_ID VISITOR_TEAM_ID SEASON
        LIVE_PERIOD LIVE_PC_TIME ATTENDANCE GAME_TIME]
    end

    def game_row
      ["2024-10-22", 3, "Final", Team::GSW, 1_610_612_747, "2024-25", 4, "0:00", 18_064, "2:18"]
    end

    def line_headers
      %w[TEAM_ID PTS_QTR1 PTS_QTR2 PTS_QTR3 PTS_QTR4 PTS_OT1 PTS]
    end

    def home_line_row
      [Team::GSW, 28, 32, 25, 33, 0, 118]
    end

    def visitor_line_row
      [1_610_612_747, 25, 28, 30, 26, 0, 109]
    end

    def official_headers
      %w[OFFICIAL_ID FIRST_NAME LAST_NAME JERSEY_NUM]
    end

    def official_rows
      [[1, "Scott", "Foster", "48"], [2, "Tony", "Brothers", "25"]]
    end

    def other_headers
      %w[LEAD_CHANGES TIMES_TIED ARENA]
    end

    def other_row
      [12, 8, "Chase Center"]
    end
  end
end
