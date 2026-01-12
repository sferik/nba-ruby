require_relative "../../test_helper"
require_relative "team_game_logs_test_helper"

module NBA
  class TeamGameLogsMissingKeysTest < Minitest::Test
    include TeamGameLogsTestHelper

    cover TeamGameLogs

    def test_handles_missing_season_year
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("SEASON_YEAR").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.season_year
    end

    def test_handles_missing_team_id
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("TEAM_ID").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.team_id
    end

    def test_handles_missing_team_abbreviation
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("TEAM_ABBREVIATION").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.team_abbreviation
    end

    def test_handles_missing_team_name
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("TEAM_NAME").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.team_name
    end

    def test_handles_missing_game_id
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("GAME_ID").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.game_id
    end

    def test_handles_missing_game_date
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("GAME_DATE").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.game_date
    end

    def test_handles_missing_matchup
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("MATCHUP").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.matchup
    end

    def test_handles_missing_wl
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("WL").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.wl
    end

    def test_handles_missing_min
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("MIN").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.min
    end
  end
end
