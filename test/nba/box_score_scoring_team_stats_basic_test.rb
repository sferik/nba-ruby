require_relative "../test_helper"

module NBA
  class BoxScoreScoringTeamStatsBasicTest < Minitest::Test
    cover BoxScoreScoring

    def test_team_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreScoring.team_stats(game: "0022400001")
    end

    def test_team_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreScoring.team_stats(game: "0022400001")

      assert_requested :get, /boxscorescoringv2.*GameID=0022400001/
    end

    def test_team_stats_parses_result_set_successfully
      stub_box_score_request

      stats = BoxScoreScoring.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_team_stats_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreScoring.team_stats(game: "001").size
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscorescoringv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [
        {name: "PlayerStats", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN PCT_FGA_2PT PCT_FGA_3PT
        PCT_PTS_2PT PCT_PTS_2PT_MR PCT_PTS_3PT PCT_PTS_FB PCT_PTS_FT PCT_PTS_OFF_TOV PCT_PTS_PAINT
        PCT_AST_2PM PCT_UAST_2PM PCT_AST_3PM PCT_UAST_3PM PCT_AST_FGM PCT_UAST_FGM]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        0.45, 0.55, 0.25, 0.1, 0.45, 0.12, 0.15, 0.08, 0.30, 0.6, 0.4, 0.7, 0.3, 0.65, 0.35]
    end
  end
end
