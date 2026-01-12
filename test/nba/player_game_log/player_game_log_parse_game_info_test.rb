require_relative "../../test_helper"

module NBA
  class PlayerGameLogParseGameInfoTest < Minitest::Test
    cover PlayerGameLog

    def test_find_parses_season_and_player_id
      stub_game_log_request

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal "22024", log.season_id
      assert_equal 201_939, log.player_id
    end

    def test_find_parses_game_id_and_date
      stub_game_log_request

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal "0022400001", log.game_id
      assert_equal "OCT 22, 2024", log.game_date
    end

    def test_find_parses_matchup_and_result
      stub_game_log_request

      log = PlayerGameLog.find(player: 201_939).first

      assert_equal "GSW vs. LAL", log.matchup
      assert_equal "W", log.wl
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
