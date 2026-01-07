require_relative "../test_helper"

module NBA
  class PlayerGameLogsTest < Minitest::Test
    cover PlayerGameLogs

    def test_all_returns_collection
      stub_game_logs_request

      result = PlayerGameLogs.all

      assert_instance_of Collection, result
    end

    def test_all_sends_correct_endpoint
      stub_request(:get, /playergamelogs/).to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all

      assert_requested :get, /playergamelogs/
    end

    def test_all_parses_game_info
      stub_game_logs_request

      log = PlayerGameLogs.all.first

      assert_equal "2024-25", log.season_id
      assert_equal "0022400001", log.game_id
      assert_equal "NOV 01, 2024", log.game_date
      assert_equal "GSW vs. LAL", log.matchup
    end

    def test_all_parses_player_info
      stub_game_logs_request

      log = PlayerGameLogs.all.first

      assert_equal 201_939, log.player_id
      assert_equal "Stephen Curry", log.player_name
      assert_equal 1_610_612_744, log.team_id
    end

    def test_all_parses_team_info
      stub_game_logs_request

      log = PlayerGameLogs.all.first

      assert_equal "GSW", log.team_abbreviation
      assert_equal "Warriors", log.team_name
    end

    def test_all_parses_result
      stub_game_logs_request

      log = PlayerGameLogs.all.first

      assert_equal "W", log.wl
      assert_equal 36, log.min
    end

    def test_all_parses_shooting_stats
      stub_game_logs_request

      log = PlayerGameLogs.all.first

      assert_equal 10, log.fgm
      assert_equal 20, log.fga
      assert_in_delta 0.5, log.fg_pct
    end

    def test_all_parses_three_point_stats
      stub_game_logs_request

      log = PlayerGameLogs.all.first

      assert_equal 6, log.fg3m
      assert_equal 12, log.fg3a
      assert_in_delta 0.4, log.fg3_pct
    end

    def test_all_parses_free_throw_stats
      stub_game_logs_request

      log = PlayerGameLogs.all.first

      assert_equal 7, log.ftm
      assert_equal 8, log.fta
      assert_in_delta 0.833, log.ft_pct
    end

    def test_all_parses_counting_stats
      stub_game_logs_request

      log = PlayerGameLogs.all.first

      assert_equal 2, log.oreb
      assert_equal 9, log.dreb
      assert_equal 14, log.reb
    end

    def test_all_parses_other_counting_stats
      stub_game_logs_request

      log = PlayerGameLogs.all.first

      assert_equal 11, log.ast
      assert_equal 3, log.stl
      assert_equal 1, log.blk
      assert_equal 4, log.tov
    end

    def test_all_parses_final_stats
      stub_game_logs_request

      log = PlayerGameLogs.all.first

      assert_equal 5, log.pf
      assert_equal 30, log.pts
      assert_equal 15, log.plus_minus
    end

    private

    def stub_game_logs_request
      stub_request(:get, /playergamelogs/).to_return(body: game_logs_response.to_json)
    end

    def game_logs_headers
      %w[SEASON_YEAR PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION TEAM_NAME GAME_ID GAME_DATE
        MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def game_logs_row
      ["2024-25", 201_939, "Stephen Curry", 1_610_612_744, "GSW", "Warriors", "0022400001", "NOV 01, 2024",
        "GSW vs. LAL", "W", 36, 10, 20, 0.5, 6, 12, 0.4, 7, 8, 0.833, 2, 9, 14, 11, 3, 1, 4, 5, 30, 15]
    end

    def game_logs_response
      {resultSets: [{name: "PlayerGameLogs", headers: game_logs_headers, rowSet: [game_logs_row]}]}
    end
  end
end
