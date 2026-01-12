require_relative "../../test_helper"

module NBA
  class BoxScoreTraditionalParseTeamStatsTest < Minitest::Test
    cover BoxScoreTraditional

    def test_parses_team_identity
      stub_box_score_request

      stat = BoxScoreTraditional.team_stats(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
    end

    def test_parses_team_location
      stub_box_score_request

      stat = BoxScoreTraditional.team_stats(game: "0022400001").first

      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Golden State", stat.team_city
      assert_equal "240:00", stat.min
    end

    def test_parses_team_shooting
      stub_box_score_request

      stat = BoxScoreTraditional.team_stats(game: "0022400001").first

      assert_equal 42, stat.fgm
      assert_equal 88, stat.fga
      assert_in_delta 0.477, stat.fg_pct
    end

    def test_parses_team_counting
      stub_box_score_request

      stat = BoxScoreTraditional.team_stats(game: "0022400001").first

      assert_equal 45, stat.reb
      assert_equal 28, stat.ast
      assert_equal 119, stat.pts
    end

    private

    def stub_box_score_request
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: box_score_response.to_json)
    end

    def box_score_response
      {resultSets: [{name: "TeamStats", headers: team_headers, rowSet: [team_row]}]}
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00", 42, 88, 0.477, 15, 40,
        0.375, 20, 25, 0.8, 10, 35, 45, 28, 8, 5, 12, 18, 119, 12]
    end
  end
end
