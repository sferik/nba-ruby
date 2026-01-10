require_relative "../test_helper"
require_relative "team_game_logs_test_helper"

module NBA
  class TeamGameLogsShootingKeysTest < Minitest::Test
    include TeamGameLogsTestHelper

    cover TeamGameLogs

    def test_handles_missing_fgm
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("FGM").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.fgm
    end

    def test_handles_missing_fga
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("FGA").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.fga
    end

    def test_handles_missing_fg_pct
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("FG_PCT").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.fg_pct
    end

    def test_handles_missing_fg3m
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("FG3M").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.fg3m
    end

    def test_handles_missing_fg3a
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("FG3A").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.fg3a
    end

    def test_handles_missing_fg3_pct
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("FG3_PCT").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.fg3_pct
    end

    def test_handles_missing_ftm
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("FTM").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.ftm
    end

    def test_handles_missing_fta
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("FTA").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.fta
    end

    def test_handles_missing_ft_pct
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("FT_PCT").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.ft_pct
    end
  end
end
