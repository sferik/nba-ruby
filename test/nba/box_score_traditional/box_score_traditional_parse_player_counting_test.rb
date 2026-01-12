require_relative "../../test_helper"

module NBA
  class BoxScoreTraditionalParsePlayerCountingTest < Minitest::Test
    cover BoxScoreTraditional

    def test_parses_rebound_stats
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal 0, stat.oreb
      assert_equal 4, stat.dreb
      assert_equal 4, stat.reb
    end

    def test_parses_playmaking_stats
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal 8, stat.ast
      assert_equal 1, stat.stl
      assert_equal 0, stat.blk
    end

    def test_parses_other_stats
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal 3, stat.tov
      assert_equal 2, stat.pf
      assert_equal 31, stat.pts
      assert_equal 15, stat.plus_minus
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "PlayerStats", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 10, 20, 0.500, 5, 12, 0.417, 6, 6, 1.0, 0, 4, 4, 8, 1, 0, 3, 2, 31, 15]
    end
  end
end
