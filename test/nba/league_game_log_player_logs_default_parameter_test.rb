require_relative "../test_helper"

module NBA
  class LeagueGameLogPlayerLogsDefaultParameterTest < Minitest::Test
    cover LeagueGameLog

    def test_player_logs_uses_default_season_type
      stub_game_log_request

      LeagueGameLog.player_logs(season: 2024)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    private

    def stub_game_log_request
      stub_request(:get, /leaguegamelog/).to_return(body: {resultSets: []}.to_json)
    end
  end
end
