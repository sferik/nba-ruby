require_relative "../test_helper"

module NBA
  class BoxScoreUsagePlayerStatsBasicTest < Minitest::Test
    cover BoxScoreUsage

    def test_player_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreUsage.player_stats(game: "0022400001")
    end

    def test_player_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreUsage.player_stats(game: "0022400001")

      assert_requested :get, /boxscoreusagev2.*GameID=0022400001/
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoreusagev2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN USG_PCT PCT_FGM PCT_FGA PCT_FG3M PCT_FG3A PCT_FTM PCT_FTA PCT_OREB PCT_DREB PCT_REB
        PCT_AST PCT_TOV PCT_STL PCT_BLK PCT_BLKA PCT_PF PCT_PFD PCT_PTS]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 0.28, 0.25, 0.22, 0.35, 0.30, 0.20, 0.18, 0.05, 0.12, 0.10,
        0.30, 0.15, 0.08, 0.02, 0.03, 0.10, 0.15, 0.28]
    end
  end
end
