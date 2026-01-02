require_relative "../test_helper"

module NBA
  class LeagueGameLogPlayerShootingMappingTest < Minitest::Test
    cover LeagueGameLog

    def test_maps_fgm
      stub_player_logs_request

      assert_equal 11, fetch_player_log.fgm
    end

    def test_maps_fga
      stub_player_logs_request

      assert_equal 22, fetch_player_log.fga
    end

    def test_maps_fg_pct
      stub_player_logs_request

      assert_in_delta 0.500, fetch_player_log.fg_pct
    end

    def test_maps_fg3m
      stub_player_logs_request

      assert_equal 5, fetch_player_log.fg3m
    end

    def test_maps_fg3a
      stub_player_logs_request

      assert_equal 12, fetch_player_log.fg3a
    end

    def test_maps_fg3_pct
      stub_player_logs_request

      assert_in_delta 0.417, fetch_player_log.fg3_pct
    end

    def test_maps_ftm
      stub_player_logs_request

      assert_equal 6, fetch_player_log.ftm
    end

    def test_maps_fta
      stub_player_logs_request

      assert_equal 6, fetch_player_log.fta
    end

    def test_maps_ft_pct
      stub_player_logs_request

      assert_in_delta 1.0, fetch_player_log.ft_pct
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
