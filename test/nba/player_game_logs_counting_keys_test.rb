require_relative "../test_helper"

module NBA
  class PlayerGameLogsCountingKeysTest < Minitest::Test
    cover PlayerGameLogs

    def test_handles_missing_oreb
      stub_request(:get, /playergamelogs/).to_return(body: response_without("OREB").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.oreb
    end

    def test_handles_missing_dreb
      stub_request(:get, /playergamelogs/).to_return(body: response_without("DREB").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.dreb
    end

    def test_handles_missing_reb
      stub_request(:get, /playergamelogs/).to_return(body: response_without("REB").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.reb
    end

    def test_handles_missing_ast
      stub_request(:get, /playergamelogs/).to_return(body: response_without("AST").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.ast
    end

    def test_handles_missing_stl
      stub_request(:get, /playergamelogs/).to_return(body: response_without("STL").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.stl
    end

    def test_handles_missing_blk
      stub_request(:get, /playergamelogs/).to_return(body: response_without("BLK").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.blk
    end

    def test_handles_missing_tov
      stub_request(:get, /playergamelogs/).to_return(body: response_without("TOV").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.tov
    end

    def test_handles_missing_pf
      stub_request(:get, /playergamelogs/).to_return(body: response_without("PF").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.pf
    end

    def test_handles_missing_pts
      stub_request(:get, /playergamelogs/).to_return(body: response_without("PTS").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.pts
    end

    def test_handles_missing_plus_minus
      stub_request(:get, /playergamelogs/).to_return(body: response_without("PLUS_MINUS").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.plus_minus
    end

    private

    def all_headers
      %w[SEASON_YEAR PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION TEAM_NAME GAME_ID GAME_DATE
        MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def all_values
      ["2024-25", 201_939, "Stephen Curry", 1_610_612_744, "GSW", "Warriors", "0022400001", "NOV 01, 2024",
        "GSW vs. LAL", "W", 36, 10, 20, 0.5, 6, 12, 0.4, 7, 8, 0.833, 2, 9, 14, 11, 3, 1, 4, 5, 30, 15]
    end

    def response_without(key)
      index = all_headers.index(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      values = all_values.reject.with_index { |_, i| i.eql?(index) }
      {resultSets: [{name: "PlayerGameLogs", headers: headers, rowSet: [values]}]}
    end
  end
end
