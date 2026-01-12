require_relative "../../test_helper"

module NBA
  class PlayerGameLogsMissingKeysTest < Minitest::Test
    cover PlayerGameLogs

    def test_handles_missing_game_id
      stub_request(:get, /playergamelogs/).to_return(body: response_without("GAME_ID").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.game_id
    end

    def test_handles_missing_player_id
      stub_request(:get, /playergamelogs/).to_return(body: response_without("PLAYER_ID").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.player_id
    end

    def test_handles_missing_player_name
      stub_request(:get, /playergamelogs/).to_return(body: response_without("PLAYER_NAME").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.player_name
    end

    def test_handles_missing_team_id
      stub_request(:get, /playergamelogs/).to_return(body: response_without("TEAM_ID").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.team_id
    end

    def test_handles_missing_team_abbreviation
      stub_request(:get, /playergamelogs/).to_return(body: response_without("TEAM_ABBREVIATION").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.team_abbreviation
    end

    def test_handles_missing_team_name
      stub_request(:get, /playergamelogs/).to_return(body: response_without("TEAM_NAME").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.team_name
    end

    def test_handles_missing_season_year
      stub_request(:get, /playergamelogs/).to_return(body: response_without("SEASON_YEAR").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.season_id
    end

    def test_handles_missing_game_date
      stub_request(:get, /playergamelogs/).to_return(body: response_without("GAME_DATE").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.game_date
    end

    def test_handles_missing_matchup
      stub_request(:get, /playergamelogs/).to_return(body: response_without("MATCHUP").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.matchup
    end

    def test_handles_missing_wl
      stub_request(:get, /playergamelogs/).to_return(body: response_without("WL").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.wl
    end

    def test_handles_missing_min
      stub_request(:get, /playergamelogs/).to_return(body: response_without("MIN").to_json)

      log = PlayerGameLogs.all.first

      assert_nil log.min
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
