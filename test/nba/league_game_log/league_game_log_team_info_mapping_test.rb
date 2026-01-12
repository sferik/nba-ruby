require_relative "../../test_helper"

module NBA
  class LeagueGameLogTeamInfoMappingTest < Minitest::Test
    cover LeagueGameLog

    def test_maps_team_id
      stub_team_logs_request

      assert_equal Team::GSW, fetch_team_log.team_id
    end

    def test_maps_game_id
      stub_team_logs_request

      assert_equal "0022400001", fetch_team_log.game_id
    end

    def test_maps_game_date
      stub_team_logs_request

      assert_equal "2024-10-22", fetch_team_log.game_date
    end

    def test_maps_matchup
      stub_team_logs_request

      assert_equal "GSW vs. LAL", fetch_team_log.matchup
    end

    def test_maps_win_loss
      stub_team_logs_request

      assert_equal "W", fetch_team_log.wl
    end

    def test_maps_minutes
      stub_team_logs_request

      assert_equal 240, fetch_team_log.min
    end

    private

    def fetch_team_log
      LeagueGameLog.team_logs(season: 2024).first
    end

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
