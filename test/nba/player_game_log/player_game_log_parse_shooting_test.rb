require_relative "../../test_helper"

module NBA
  class PlayerGameLogParseShootingTest < Minitest::Test
    cover PlayerGameLog

    def test_find_parses_field_goal_stats
      stub_game_log_request

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal 10, log.fgm
      assert_equal 20, log.fga
      assert_in_delta 0.5, log.fg_pct
    end

    def test_find_parses_three_point_stats
      stub_game_log_request

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal 4, log.fg3m
      assert_equal 10, log.fg3a
      assert_in_delta 0.4, log.fg3_pct
    end

    def test_find_parses_free_throw_stats
      stub_game_log_request

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal 5, log.ftm
      assert_equal 6, log.fta
      assert_in_delta 0.833, log.ft_pct
    end

    private

    def stub_game_log_request
      stub_request(:get, /playergamelog/).to_return(body: game_log_response.to_json)
    end

    def game_log_response = {resultSets: [{headers: game_log_headers, rowSet: [game_log_row]}]}

    def game_log_headers
      %w[SEASON_ID Player_ID Game_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def game_log_row
      ["22024", 201_939, "0022400001", "OCT 22, 2024", "GSW vs. LAL", "W", 36, 10, 20, 0.5, 4, 10, 0.4, 5, 6, 0.833,
        2, 5, 7, 10, 2, 1, 3, 2, 30, 12]
    end
  end
end
