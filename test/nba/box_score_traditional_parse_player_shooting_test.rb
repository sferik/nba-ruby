require_relative "../test_helper"

module NBA
  class BoxScoreTraditionalParsePlayerShootingTest < Minitest::Test
    cover BoxScoreTraditional

    def test_parses_field_goal_stats
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal 10, stat.fgm
      assert_equal 20, stat.fga
      assert_in_delta 0.500, stat.fg_pct
    end

    def test_parses_three_point_stats
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal 5, stat.fg3m
      assert_equal 12, stat.fg3a
      assert_in_delta 0.417, stat.fg3_pct
    end

    def test_parses_free_throw_stats
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal 6, stat.ftm
      assert_equal 6, stat.fta
      assert_in_delta 1.0, stat.ft_pct
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
