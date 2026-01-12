require_relative "../../test_helper"

module NBA
  class BoxScoreSummaryV2FindTest < Minitest::Test
    cover BoxScoreSummaryV2

    def test_find_returns_box_score_summary
      stub_summary_request

      result = BoxScoreSummaryV2.find(game: "0022400001")

      assert_instance_of BoxScoreSummary, result
    end

    def test_find_uses_correct_game_id_in_path
      stub_summary_request

      BoxScoreSummaryV2.find(game: "0022400001")

      assert_requested :get, /boxscoresummaryv2\?GameID=0022400001/
    end

    def test_find_parses_summary_successfully
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal "0022400001", summary.game_id
      assert_equal Team::GSW, summary.home_team_id
      assert_equal 1_610_612_747, summary.visitor_team_id
    end

    def test_find_parses_scores
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal 118, summary.home_pts
      assert_equal 109, summary.visitor_pts
    end

    def test_find_parses_officials
      stub_summary_request

      summary = BoxScoreSummaryV2.find(game: "0022400001")

      assert_equal ["Scott Foster", "Tony Brothers"], summary.officials
    end

    def test_find_accepts_game_object
      stub_summary_request
      game = Game.new(id: "0022400001")

      BoxScoreSummaryV2.find(game: game)

      assert_requested :get, /GameID=0022400001/
    end

    def test_find_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, summary_response.to_json, [String]

      BoxScoreSummaryV2.find(game: "0022400001", client: mock_client)

      mock_client.verify
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
