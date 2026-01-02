require_relative "../test_helper"

module NBA
  class LeagueGameLogDefaultSeasonTest < Minitest::Test
    cover LeagueGameLog

    def test_player_logs_uses_default_season_from_utils
      stub_game_log_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      LeagueGameLog.player_logs

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_team_logs_uses_default_season_from_utils
      stub_game_log_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      LeagueGameLog.team_logs

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_player_logs_uses_default_season_type_when_no_args
      stub_game_log_request

      LeagueGameLog.player_logs

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_team_logs_uses_default_season_type_when_no_args
      stub_game_log_request

      LeagueGameLog.team_logs

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    private

    def stub_game_log_request
      stub_request(:get, /leaguegamelog/).to_return(body: {resultSets: []}.to_json)
    end
  end
end
