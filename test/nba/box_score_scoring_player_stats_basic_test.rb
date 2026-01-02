require_relative "../test_helper"

module NBA
  class BoxScoreScoringPlayerStatsBasicTest < Minitest::Test
    cover BoxScoreScoring

    def test_player_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreScoring.player_stats(game: "0022400001")
    end

    def test_player_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreScoring.player_stats(game: "0022400001")

      assert_requested :get, /boxscorescoringv2.*GameID=0022400001/
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscorescoringv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "TeamStats", headers: team_headers, rowSet: []}
      ]}
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN PCT_FGA_2PT PCT_FGA_3PT PCT_PTS_2PT PCT_PTS_2PT_MR PCT_PTS_3PT PCT_PTS_FB PCT_PTS_FT
        PCT_PTS_OFF_TOV PCT_PTS_PAINT PCT_AST_2PM PCT_UAST_2PM PCT_AST_3PM PCT_UAST_3PM PCT_AST_FGM PCT_UAST_FGM]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 0.4, 0.6, 0.2, 0.1, 0.5, 0.15, 0.1, 0.05, 0.25, 0.3, 0.7, 0.5, 0.5, 0.4, 0.6]
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN PCT_FGA_2PT PCT_FGA_3PT
        PCT_PTS_2PT PCT_PTS_2PT_MR PCT_PTS_3PT PCT_PTS_FB PCT_PTS_FT PCT_PTS_OFF_TOV PCT_PTS_PAINT
        PCT_AST_2PM PCT_UAST_2PM PCT_AST_3PM PCT_UAST_3PM PCT_AST_FGM PCT_UAST_FGM]
    end
  end
end
