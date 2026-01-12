require_relative "../../test_helper"

module NBA
  class LeagueGameLogPlayerGameInfoMappingTest < Minitest::Test
    cover LeagueGameLog

    def test_maps_season_id
      stub_player_logs_request

      assert_equal "22024", fetch_player_log.season_id
    end

    def test_maps_player_id
      stub_player_logs_request

      assert_equal 201_939, fetch_player_log.player_id
    end

    def test_maps_game_id
      stub_player_logs_request

      assert_equal "0022400001", fetch_player_log.game_id
    end

    def test_maps_game_date
      stub_player_logs_request

      assert_equal "2024-10-22", fetch_player_log.game_date
    end

    def test_maps_matchup
      stub_player_logs_request

      assert_equal "GSW vs. LAL", fetch_player_log.matchup
    end

    def test_maps_win_loss
      stub_player_logs_request

      assert_equal "W", fetch_player_log.wl
    end

    def test_maps_minutes
      stub_player_logs_request

      assert_equal 34, fetch_player_log.min
    end

    private

    def fetch_player_log
      LeagueGameLog.player_logs(season: 2024).first
    end

    def stub_player_logs_request
      stub_request(:get, /leaguegamelog/).to_return(body: player_logs_response.to_json)
    end

    def player_logs_response
      {resultSets: [{name: "LeagueGameLog", headers: player_log_headers, rowSet: [player_log_row]}]}
    end

    def player_log_headers
      %w[SEASON_ID PLAYER_ID GAME_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A
        FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def player_log_row
      ["22024", 201_939, "0022400001", "2024-10-22", "GSW vs. LAL", "W", 34, 11, 22, 0.500,
        5, 12, 0.417, 6, 6, 1.0, 0, 5, 5, 7, 2, 0, 3, 2, 33, 15]
    end
  end
end
