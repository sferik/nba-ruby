require_relative "../test_helper"

module NBA
  class TeamGameLogsDefaultParamsTest < Minitest::Test
    cover TeamGameLogs

    def test_all_uses_default_season_from_utils
      stub_team_game_logs_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      TeamGameLogs.all

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_all_uses_default_season_type
      stub_team_game_logs_request

      TeamGameLogs.all(season: 2024)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_all_uses_default_per_mode
      stub_team_game_logs_request

      TeamGameLogs.all(season: 2024)

      assert_requested :get, /PerModeSimple=PerGame/
    end

    def test_all_does_not_include_team_id_by_default
      stub_team_game_logs_request

      TeamGameLogs.all(season: 2024)

      assert_not_requested :get, /TeamID=/
    end

    private

    def stub_team_game_logs_request
      stub_request(:get, /teamgamelogs/).to_return(body: {resultSets: []}.to_json)
    end
  end
end
