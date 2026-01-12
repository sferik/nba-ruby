require_relative "../../test_helper"
require_relative "team_game_logs_test_helper"

module NBA
  class TeamGameLogsTest < Minitest::Test
    include TeamGameLogsTestHelper

    cover TeamGameLogs

    def test_all_returns_collection
      stub_team_game_logs_request

      result = TeamGameLogs.all

      assert_instance_of Collection, result
    end

    def test_all_sends_correct_endpoint
      stub_request(:get, /teamgamelogs/).to_return(body: team_game_logs_response.to_json)

      TeamGameLogs.all

      assert_requested :get, /teamgamelogs/
    end

    def test_all_parses_game_info
      stub_team_game_logs_request

      log = TeamGameLogs.all.first

      assert_equal "2024-25", log.season_year
      assert_equal "0022400001", log.game_id
      assert_equal "2024-10-22T00:00:00", log.game_date
      assert_equal "GSW vs. LAL", log.matchup
    end

    def test_all_parses_team_info
      stub_team_game_logs_request

      log = TeamGameLogs.all.first

      assert_equal Team::GSW, log.team_id
      assert_equal "GSW", log.team_abbreviation
      assert_equal "Warriors", log.team_name
    end

    def test_all_parses_result
      stub_team_game_logs_request

      log = TeamGameLogs.all.first

      assert_equal "W", log.wl
      assert_equal 240, log.min
    end

    def test_all_parses_shooting_stats
      stub_team_game_logs_request

      log = TeamGameLogs.all.first

      assert_equal 42, log.fgm
      assert_equal 88, log.fga
      assert_in_delta 0.477, log.fg_pct
    end

    def test_all_parses_three_point_stats
      stub_team_game_logs_request

      log = TeamGameLogs.all.first

      assert_equal 15, log.fg3m
      assert_equal 38, log.fg3a
      assert_in_delta 0.395, log.fg3_pct
    end

    def test_all_parses_free_throw_stats
      stub_team_game_logs_request

      log = TeamGameLogs.all.first

      assert_equal 19, log.ftm
      assert_equal 22, log.fta
      assert_in_delta 0.864, log.ft_pct
    end

    def test_all_parses_counting_stats
      stub_team_game_logs_request

      log = TeamGameLogs.all.first

      assert_equal 10, log.oreb
      assert_equal 35, log.dreb
      assert_equal 45, log.reb
    end

    def test_all_parses_other_counting_stats
      stub_team_game_logs_request

      log = TeamGameLogs.all.first

      assert_equal 28, log.ast
      assert_equal 9, log.stl
      assert_equal 6, log.blk
      assert_equal 14, log.tov
    end

    def test_all_parses_final_stats
      stub_team_game_logs_request

      log = TeamGameLogs.all.first

      assert_equal 20, log.pf
      assert_equal 118, log.pts
      assert_equal 9, log.plus_minus
    end

    private

    def stub_team_game_logs_request
      stub_request(:get, /teamgamelogs/).to_return(body: team_game_logs_response.to_json)
    end
  end
end
