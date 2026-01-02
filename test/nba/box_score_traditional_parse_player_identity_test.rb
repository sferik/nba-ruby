require_relative "../test_helper"

module NBA
  class BoxScoreTraditionalParsePlayerIdentityTest < Minitest::Test
    cover BoxScoreTraditional

    def test_parses_game_id
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
    end

    def test_parses_team_id
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
    end

    def test_parses_team_abbreviation
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_parses_team_city
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal "Golden State", stat.team_city
    end

    def test_parses_player_id
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal 201_939, stat.player_id
    end

    def test_parses_player_name
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_parses_start_position
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal "G", stat.start_position
    end

    def test_parses_comment
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal "", stat.comment
    end

    def test_parses_minutes
      stub_box_score_request

      stat = BoxScoreTraditional.player_stats(game: "0022400001").first

      assert_equal "34:22", stat.min
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
