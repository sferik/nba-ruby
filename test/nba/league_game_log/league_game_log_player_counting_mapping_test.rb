require_relative "../../test_helper"

module NBA
  class LeagueGameLogPlayerCountingMappingTest < Minitest::Test
    cover LeagueGameLog

    def test_maps_oreb
      stub_player_logs_request

      assert_equal 0, fetch_player_log.oreb
    end

    def test_maps_dreb
      stub_player_logs_request

      assert_equal 5, fetch_player_log.dreb
    end

    def test_maps_reb
      stub_player_logs_request

      assert_equal 5, fetch_player_log.reb
    end

    def test_maps_ast
      stub_player_logs_request

      assert_equal 7, fetch_player_log.ast
    end

    def test_maps_stl
      stub_player_logs_request

      assert_equal 2, fetch_player_log.stl
    end

    def test_maps_blk
      stub_player_logs_request

      assert_equal 0, fetch_player_log.blk
    end

    def test_maps_tov
      stub_player_logs_request

      assert_equal 3, fetch_player_log.tov
    end

    def test_maps_pf
      stub_player_logs_request

      assert_equal 2, fetch_player_log.pf
    end

    def test_maps_pts
      stub_player_logs_request

      assert_equal 33, fetch_player_log.pts
    end

    def test_maps_plus_minus
      stub_player_logs_request

      assert_equal 15, fetch_player_log.plus_minus
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
