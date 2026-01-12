require_relative "../../test_helper"

module NBA
  class LeagueGameLogTeamShootingMappingTest < Minitest::Test
    cover LeagueGameLog

    def test_maps_fgm
      stub_team_logs_request

      assert_equal 44, fetch_team_log.fgm
    end

    def test_maps_fga
      stub_team_logs_request

      assert_equal 88, fetch_team_log.fga
    end

    def test_maps_fg_pct
      stub_team_logs_request

      assert_in_delta 0.500, fetch_team_log.fg_pct
    end

    def test_maps_fg3m
      stub_team_logs_request

      assert_equal 16, fetch_team_log.fg3m
    end

    def test_maps_fg3a
      stub_team_logs_request

      assert_equal 40, fetch_team_log.fg3a
    end

    def test_maps_fg3_pct
      stub_team_logs_request

      assert_in_delta 0.400, fetch_team_log.fg3_pct
    end

    def test_maps_ftm
      stub_team_logs_request

      assert_equal 18, fetch_team_log.ftm
    end

    def test_maps_fta
      stub_team_logs_request

      assert_equal 22, fetch_team_log.fta
    end

    def test_maps_ft_pct
      stub_team_logs_request

      assert_in_delta 0.818, fetch_team_log.ft_pct
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
