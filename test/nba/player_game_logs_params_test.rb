require_relative "../test_helper"

module NBA
  class PlayerGameLogsParamsTest < Minitest::Test
    cover PlayerGameLogs

    def test_all_with_season_param
      stub_request(:get, /Season=2023-24/).to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all(season: 2023)

      assert_requested :get, /Season=2023-24/
    end

    def test_all_with_season_type_param
      stub_request(:get, /SeasonType=Playoffs/).to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all(season_type: PlayerGameLogs::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_defaults_to_regular_season
      stub_request(:get, /SeasonType=Regular(%20|\+)Season/).to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all

      assert_requested :get, /SeasonType=Regular(%20|\+)Season/
    end

    def test_all_with_player_param
      stub_request(:get, /PlayerID=201939/).to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all(player: 201_939)

      assert_requested :get, /PlayerID=201939/
    end

    def test_all_with_team_param
      stub_request(:get, /TeamID=1610612744/).to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all(team: 1_610_612_744)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_all_with_per_mode_param
      stub_request(:get, /PerModeSimple=Totals/).to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all(per_mode: PlayerGameLogs::TOTALS)

      assert_requested :get, /PerModeSimple=Totals/
    end

    def test_all_defaults_to_per_game
      stub_request(:get, /PerModeSimple=PerGame/).to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all

      assert_requested :get, /PerModeSimple=PerGame/
    end

    def test_all_returns_empty_collection_for_nil_response
      stub_request(:get, /playergamelogs/).to_return(body: nil)

      result = PlayerGameLogs.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_parses_from_correct_result_set
      stub_request(:get, /playergamelogs/).to_return(body: multi_result_response.to_json)

      log = PlayerGameLogs.all.first

      assert_equal 201_939, log.player_id
    end

    private

    def multi_result_response
      {resultSets: [
        {name: "OtherResultSet", headers: ["PLAYER_ID"], rowSet: [[12_345]]},
        {name: "PlayerGameLogs", headers: game_logs_headers, rowSet: [game_logs_row]}
      ]}
    end

    def game_logs_headers
      %w[SEASON_YEAR PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION TEAM_NAME GAME_ID GAME_DATE
        MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def game_logs_row
      ["2024-25", 201_939, "Stephen Curry", 1_610_612_744, "GSW", "Warriors", "0022400001", "NOV 01, 2024",
        "GSW vs. LAL", "W", 36, 10, 20, 0.5, 6, 12, 0.4, 7, 8, 0.833, 2, 9, 14, 11, 3, 1, 4, 5, 30, 15]
    end

    def game_logs_response
      {resultSets: [{name: "PlayerGameLogs", headers: game_logs_headers, rowSet: [game_logs_row]}]}
    end
  end
end
