require_relative "../test_helper"

module NBA
  class LeagueGameLogPlayerLogsTest < Minitest::Test
    cover LeagueGameLog

    def test_player_logs_returns_collection
      stub_player_logs_request

      result = LeagueGameLog.player_logs(season: 2024)

      assert_instance_of Collection, result
    end

    def test_player_logs_uses_correct_season_in_path
      stub_player_logs_request

      LeagueGameLog.player_logs(season: 2024)

      assert_requested :get, /leaguegamelog.*Season=2024-25/
    end

    def test_player_logs_uses_player_type_in_path
      stub_player_logs_request

      LeagueGameLog.player_logs(season: 2024)

      assert_requested :get, /PlayerOrTeam=P/
    end

    def test_player_logs_parses_logs_successfully
      stub_player_logs_request

      logs = LeagueGameLog.player_logs(season: 2024)

      assert_equal 1, logs.size
      assert_equal 201_939, logs.first.player_id
    end

    def test_player_logs_accepts_season_type_parameter
      stub_player_logs_request

      LeagueGameLog.player_logs(season: 2024, season_type: LeagueGameLog::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    private

    def stub_player_logs_request
      stub_request(:get, /leaguegamelog/).to_return(body: player_logs_response.to_json)
    end

    def player_logs_response
      {resultSets: [{name: "LeagueGameLog", headers: player_log_headers, rowSet: [player_log_row]}]}
    end

    def player_log_headers
      %w[SEASON_ID PLAYER_ID GAME_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A
        FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def player_log_row
      ["22024", 201_939, "0022400001", "2024-10-22", "GSW vs. LAL", "W", 34, 11, 22, 0.500,
        5, 12, 0.417, 6, 6, 1.0, 0, 5, 5, 7, 2, 0, 3, 2, 33, 15]
    end
  end
end
