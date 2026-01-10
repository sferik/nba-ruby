require_relative "../test_helper"
require_relative "team_game_logs_test_helper"

module NBA
  class TeamGameLogsCountingKeysTest < Minitest::Test
    include TeamGameLogsTestHelper

    cover TeamGameLogs

    def test_handles_missing_oreb
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("OREB").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.oreb
    end

    def test_handles_missing_dreb
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("DREB").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.dreb
    end

    def test_handles_missing_reb
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("REB").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.reb
    end

    def test_handles_missing_ast
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("AST").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.ast
    end

    def test_handles_missing_stl
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("STL").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.stl
    end

    def test_handles_missing_blk
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("BLK").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.blk
    end

    def test_handles_missing_tov
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("TOV").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.tov
    end

    def test_handles_missing_pf
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("PF").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.pf
    end

    def test_handles_missing_pts
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("PTS").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.pts
    end

    def test_handles_missing_plus_minus
      stub_request(:get, /teamgamelogs/).to_return(body: build_response_without_key("PLUS_MINUS").to_json)

      log = TeamGameLogs.all(season: 2024).first

      assert_nil log.plus_minus
    end
  end
end
