require_relative "../test_helper"

module NBA
  class PlayerGameLogParseCountingTest < Minitest::Test
    cover PlayerGameLog

    def test_find_parses_minutes
      stub_game_log_request

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal 36, log.min
    end

    def test_find_parses_rebounds
      stub_game_log_request

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal 2, log.oreb
      assert_equal 5, log.dreb
      assert_equal 7, log.reb
    end

    def test_find_parses_playmaking_stats
      stub_game_log_request

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal 10, log.ast
      assert_equal 2, log.stl
      assert_equal 1, log.blk
    end

    def test_find_parses_other_counting_stats
      stub_game_log_request

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal 3, log.tov
      assert_equal 2, log.pf
      assert_equal 30, log.pts
      assert_equal 12, log.plus_minus
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
