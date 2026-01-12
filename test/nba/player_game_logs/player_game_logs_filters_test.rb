require_relative "../../test_helper"

module NBA
  class PlayerGameLogsFiltersTest < Minitest::Test
    cover PlayerGameLogs

    def test_all_without_player_excludes_player_id_param
      stub = stub_request(:get, /playergamelogs/)
        .with { |req| !req.uri.to_s.include?("PlayerID") }
        .to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all

      assert_requested stub
    end

    def test_all_without_team_excludes_team_id_param
      stub = stub_request(:get, /playergamelogs/)
        .with { |req| !req.uri.to_s.include?("TeamID") }
        .to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all

      assert_requested stub
    end

    def test_all_with_player_object
      player = Player.new(id: 201_939)
      stub_request(:get, /PlayerID=201939/).to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all(player: player)

      assert_requested :get, /PlayerID=201939/
    end

    def test_all_with_team_object
      team = Team.new(id: 1_610_612_744)
      stub_request(:get, /TeamID=1610612744/).to_return(body: game_logs_response.to_json)

      PlayerGameLogs.all(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_constants_defined
      assert_equal "Regular Season", PlayerGameLogs::REGULAR_SEASON
      assert_equal "Playoffs", PlayerGameLogs::PLAYOFFS
      assert_equal "PerGame", PlayerGameLogs::PER_GAME
      assert_equal "Totals", PlayerGameLogs::TOTALS
      assert_equal "PlayerGameLogs", PlayerGameLogs::RESULT_SET_NAME
    end

    private

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
