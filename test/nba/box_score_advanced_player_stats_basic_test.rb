require_relative "../test_helper"

module NBA
  class BoxScoreAdvancedPlayerStatsBasicTest < Minitest::Test
    cover BoxScoreAdvanced

    def test_player_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreAdvanced.player_stats(game: "0022400001")
    end

    def test_player_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreAdvanced.player_stats(game: "0022400001")

      assert_requested :get, /boxscoreadvancedv2.*GameID=0022400001/
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "TeamStats", headers: team_headers, rowSet: []}
      ]}
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN E_OFF_RATING OFF_RATING E_DEF_RATING DEF_RATING E_NET_RATING NET_RATING
        AST_PCT AST_TOV AST_RATIO OREB_PCT DREB_PCT REB_PCT TM_TOV_PCT EFG_PCT TS_PCT
        USG_PCT E_USG_PCT E_PACE PACE PACE_PER40 POSS PIE]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 115.0, 118.0, 105.0, 108.0, 10.0, 10.0,
        0.35, 2.5, 0.25, 0.05, 0.15, 0.10, 0.12, 0.55, 0.60,
        0.28, 0.30, 98.0, 100.0, 102.0, 50, 0.15]
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN E_OFF_RATING OFF_RATING
        E_DEF_RATING DEF_RATING E_NET_RATING NET_RATING AST_PCT AST_TOV AST_RATIO
        OREB_PCT DREB_PCT REB_PCT TM_TOV_PCT EFG_PCT TS_PCT E_PACE PACE PACE_PER40 POSS PIE]
    end
  end
end
