require_relative "../test_helper"

module NBA
  class PlayerGameLogsShootingKeysTest < Minitest::Test
    cover PlayerGameLogs

    def test_handles_missing_fgm
      stub_request(:get, /playergamelogs/).to_return(body: response_without("FGM").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.fgm
    end

    def test_handles_missing_fga
      stub_request(:get, /playergamelogs/).to_return(body: response_without("FGA").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.fga
    end

    def test_handles_missing_fg_pct
      stub_request(:get, /playergamelogs/).to_return(body: response_without("FG_PCT").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.fg_pct
    end

    def test_handles_missing_fg3m
      stub_request(:get, /playergamelogs/).to_return(body: response_without("FG3M").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.fg3m
    end

    def test_handles_missing_fg3a
      stub_request(:get, /playergamelogs/).to_return(body: response_without("FG3A").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.fg3a
    end

    def test_handles_missing_fg3_pct
      stub_request(:get, /playergamelogs/).to_return(body: response_without("FG3_PCT").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.fg3_pct
    end

    def test_handles_missing_ftm
      stub_request(:get, /playergamelogs/).to_return(body: response_without("FTM").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.ftm
    end

    def test_handles_missing_fta
      stub_request(:get, /playergamelogs/).to_return(body: response_without("FTA").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.fta
    end

    def test_handles_missing_ft_pct
      stub_request(:get, /playergamelogs/).to_return(body: response_without("FT_PCT").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.ft_pct
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
