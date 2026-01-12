require_relative "../../test_helper"

module NBA
  class LeagueGameLogTeamCountingMappingTest < Minitest::Test
    cover LeagueGameLog

    def test_maps_oreb
      stub_team_logs_request

      assert_equal 10, fetch_team_log.oreb
    end

    def test_maps_dreb
      stub_team_logs_request

      assert_equal 35, fetch_team_log.dreb
    end

    def test_maps_reb
      stub_team_logs_request

      assert_equal 45, fetch_team_log.reb
    end

    def test_maps_ast
      stub_team_logs_request

      assert_equal 30, fetch_team_log.ast
    end

    def test_maps_stl
      stub_team_logs_request

      assert_equal 8, fetch_team_log.stl
    end

    def test_maps_blk
      stub_team_logs_request

      assert_equal 5, fetch_team_log.blk
    end

    def test_maps_tov
      stub_team_logs_request

      assert_equal 12, fetch_team_log.tov
    end

    def test_maps_pf
      stub_team_logs_request

      assert_equal 20, fetch_team_log.pf
    end

    def test_maps_pts
      stub_team_logs_request

      assert_equal 122, fetch_team_log.pts
    end

    def test_maps_plus_minus
      stub_team_logs_request

      assert_equal 12, fetch_team_log.plus_minus
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
