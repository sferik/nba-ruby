require_relative "../../test_helper"

module NBA
  class BoxScoreUsageTeamStatsBasicTest < Minitest::Test
    cover BoxScoreUsage

    def test_team_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreUsage.team_stats(game: "0022400001")
    end

    def test_team_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreUsage.team_stats(game: "0022400001")

      assert_requested :get, /boxscoreusagev2.*GameID=0022400001/
    end

    def test_team_stats_parses_result_set_successfully
      stub_box_score_request

      stats = BoxScoreUsage.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoreusagev2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN USG_PCT PCT_FGM PCT_FGA
        PCT_FG3M PCT_FG3A PCT_FTM PCT_FTA PCT_OREB PCT_DREB PCT_REB PCT_AST PCT_TOV
        PCT_STL PCT_BLK PCT_BLKA PCT_PF PCT_PFD PCT_PTS]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
    end
  end
end
