require_relative "../test_helper"

module NBA
  class BoxScoreSummaryV2ScoreAttributeMappingTest < Minitest::Test
    cover BoxScoreSummaryV2

    def test_maps_home_quarter_scores
      stub_summary_request
      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal [28, 32, 25, 33, 0],
        [summary.home_pts_q1, summary.home_pts_q2, summary.home_pts_q3, summary.home_pts_q4, summary.home_pts_ot]
      assert_equal 118, summary.home_pts
    end

    def test_maps_visitor_quarter_scores
      stub_summary_request
      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal [25, 28, 30, 26, 0],
        [summary.visitor_pts_q1, summary.visitor_pts_q2, summary.visitor_pts_q3, summary.visitor_pts_q4, summary.visitor_pts_ot]
      assert_equal 109, summary.visitor_pts
    end

    def test_maps_other_stats
      stub_summary_request
      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal 12, summary.lead_changes
      assert_equal 8, summary.times_tied
      assert_equal "Chase Center", summary.arena
      assert_equal ["Scott Foster", "Tony Brothers"], summary.officials
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
