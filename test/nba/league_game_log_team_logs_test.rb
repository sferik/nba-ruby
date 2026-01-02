require_relative "../test_helper"

module NBA
  class LeagueGameLogTeamLogsTest < Minitest::Test
    cover LeagueGameLog

    def test_team_logs_returns_collection
      stub_team_logs_request

      result = LeagueGameLog.team_logs(season: 2024)

      assert_instance_of Collection, result
    end

    def test_team_logs_uses_team_type_in_path
      stub_team_logs_request

      LeagueGameLog.team_logs(season: 2024)

      assert_requested :get, /PlayerOrTeam=T/
    end

    def test_team_logs_parses_logs_successfully
      stub_team_logs_request

      logs = LeagueGameLog.team_logs(season: 2024)

      assert_equal 1, logs.size
      assert_equal Team::GSW, logs.first.team_id
    end

    def test_team_logs_accepts_season_type_parameter
      stub_team_logs_request

      LeagueGameLog.team_logs(season: 2024, season_type: LeagueGameLog::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_team_logs_uses_correct_season_in_path
      stub_team_logs_request

      LeagueGameLog.team_logs(season: 2024)

      assert_requested :get, /leaguegamelog.*Season=2024-25/
    end

    private

    def stub_team_logs_request
      stub_request(:get, /leaguegamelog/).to_return(body: team_logs_response.to_json)
    end

    def team_logs_response
      {resultSets: [{name: "LeagueGameLog", headers: team_log_headers, rowSet: [team_log_row]}]}
    end

    def team_log_headers
      %w[TEAM_ID GAME_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def team_log_row
      [Team::GSW, "0022400001", "2024-10-22", "GSW vs. LAL", "W", 240, 44, 88, 0.500,
        16, 40, 0.400, 18, 22, 0.818, 10, 35, 45, 30, 8, 5, 12, 20, 122, 12]
    end
  end
end
