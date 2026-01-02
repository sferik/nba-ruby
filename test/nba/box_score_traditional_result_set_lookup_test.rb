require_relative "../test_helper"

module NBA
  class BoxScoreTraditionalResultSetLookupTest < Minitest::Test
    cover BoxScoreTraditional

    def test_player_stats_finds_correct_result_set_by_name
      player_set = {name: "PlayerStats", headers: player_headers, rowSet: [player_row("001", 123)]}
      team_set = {name: "TeamStats", headers: team_headers, rowSet: [team_row("001", 456)]}
      response = {resultSets: [player_set, team_set]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      stat = BoxScoreTraditional.player_stats(game: "001").first

      assert_equal "001", stat.game_id
      assert_equal 123, stat.player_id
    end

    def test_player_stats_finds_result_set_when_not_first
      team_set = {name: "TeamStats", headers: team_headers, rowSet: [team_row("wrong", 456)]}
      player_set = {name: "PlayerStats", headers: player_headers, rowSet: [player_row("001", 123)]}
      response = {resultSets: [team_set, player_set]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      stat = BoxScoreTraditional.player_stats(game: "001").first

      assert_equal "001", stat.game_id
      assert_equal 123, stat.player_id
    end

    def test_team_stats_finds_result_set_when_not_first
      player_set = {name: "PlayerStats", headers: player_headers, rowSet: [player_row("wrong", 123)]}
      team_set = {name: "TeamStats", headers: team_headers, rowSet: [team_row("001", 456)]}
      response = {resultSets: [player_set, team_set]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      stat = BoxScoreTraditional.team_stats(game: "001").first

      assert_equal "001", stat.game_id
      assert_equal 456, stat.team_id
    end

    private

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
    end

    def player_row(game_id, player_id)
      [game_id, Team::GSW, "GSW", "Golden State", player_id, "Test Player", "G", "",
        "34:22", 10, 20, 0.500, 5, 12, 0.417, 6, 6, 1.0, 0, 4, 4, 8, 1, 0, 3, 2, 31, 15]
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
    end

    def team_row(game_id, team_id)
      [game_id, team_id, "Warriors", "GSW", "Golden State", "240:00", 42, 88, 0.477, 15, 40,
        0.375, 20, 25, 0.8, 10, 35, 45, 28, 8, 5, 12, 18, 119, 12]
    end
  end
end
