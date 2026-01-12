require_relative "../../test_helper"

module NBA
  class BoxScoreTraditionalPlayerStatsBasicTest < Minitest::Test
    cover BoxScoreTraditional

    def test_player_stats_returns_collection
      stub_box_score_request

      assert_instance_of Collection, BoxScoreTraditional.player_stats(game: "0022400001")
    end

    def test_player_stats_uses_correct_game_id_in_path
      stub_box_score_request

      BoxScoreTraditional.player_stats(game: "0022400001")

      assert_requested :get, /boxscoretraditionalv2.*GameID=0022400001/
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "TeamStats", headers: team_headers, rowSet: []}
      ]}
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 10, 20, 0.500, 5, 12, 0.417, 6, 6, 1.0, 0, 4, 4, 8, 1, 0, 3, 2, 31, 15]
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
    end
  end
end
