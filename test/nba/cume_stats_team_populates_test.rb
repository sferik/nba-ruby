require_relative "../test_helper"

module NBA
  module CumeStatsTeamPopulatesHelper
    GAME_BY_GAME_HEADERS = %w[
      PERSON_ID PLAYER_NAME JERSEY_NUM TEAM_ID GP GS ACTUAL_MINUTES ACTUAL_SECONDS
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
      OREB DREB TOT_REB AST PF STL TOV BLK PTS
      AVG_MINUTES FGM_PG FGA_PG FG3M_PG FG3A_PG FTM_PG FTA_PG
      OREB_PG DREB_PG REB_PG AST_PG PF_PG STL_PG TOV_PG BLK_PG PTS_PG
      FGM_PER_MIN FGA_PER_MIN FG3M_PER_MIN FG3A_PER_MIN FTM_PER_MIN FTA_PER_MIN
      OREB_PER_MIN DREB_PER_MIN REB_PER_MIN AST_PER_MIN PF_PER_MIN STL_PER_MIN
      TOV_PER_MIN BLK_PER_MIN PTS_PER_MIN
    ].freeze

    GAME_BY_GAME_ROW = [
      201_939, "Stephen Curry", "30", Team::GSW, 10, 10, 350, 21_000,
      100, 200, 0.500, 40, 100, 0.400, 80, 90, 0.889,
      10, 50, 60, 70, 20, 15, 25, 5, 280,
      35.0, 10.0, 20.0, 4.0, 10.0, 8.0, 9.0,
      1.0, 5.0, 6.0, 7.0, 2.0, 1.5, 2.5, 0.5, 28.0,
      0.286, 0.571, 0.114, 0.286, 0.229, 0.257,
      0.029, 0.143, 0.171, 0.200, 0.057, 0.043,
      0.071, 0.014, 0.800
    ].freeze

    TOTAL_TEAM_HEADERS = %w[
      TEAM_ID CITY NICKNAME GP GS W L W_HOME L_HOME W_ROAD L_ROAD
      TEAM_TURNOVERS TEAM_REBOUNDS
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
      OREB DREB TOT_REB AST PF STL TOV BLK PTS
    ].freeze

    TOTAL_TEAM_ROW = [
      Team::GSW, "Golden State", "Warriors", 10, 10, 8, 2, 5, 1, 3, 1,
      120, 450,
      400, 850, 0.471, 150, 400, 0.375, 180, 220, 0.818,
      100, 350, 450, 250, 180, 80, 120, 45, 1130
    ].freeze

    def response
      {resultSets: [
        {name: "GameByGameStats", headers: GAME_BY_GAME_HEADERS, rowSet: [GAME_BY_GAME_ROW]},
        {name: "TotalTeamStats", headers: TOTAL_TEAM_HEADERS, rowSet: [TOTAL_TEAM_ROW]}
      ]}
    end

    def find_result
      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)
    end
  end

  class CumeStatsTeamPopulatesPlayerBasicTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_gp
      assert_equal 10, find_result[:game_by_game].first.gp
    end

    def test_populates_gs
      assert_equal 10, find_result[:game_by_game].first.gs
    end

    def test_populates_actual_minutes
      assert_equal 350, find_result[:game_by_game].first.actual_minutes
    end

    def test_populates_actual_seconds
      assert_equal 21_000, find_result[:game_by_game].first.actual_seconds
    end

    def test_populates_jersey_num
      assert_equal "30", find_result[:game_by_game].first.jersey_num
    end

    def test_populates_player_team_id
      assert_equal Team::GSW, find_result[:game_by_game].first.team_id
    end
  end

  class CumeStatsTeamPopulatesPlayerShotTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_fgm
      assert_equal 100, find_result[:game_by_game].first.fgm
    end

    def test_populates_fga
      assert_equal 200, find_result[:game_by_game].first.fga
    end

    def test_populates_fg_pct
      assert_in_delta(0.500, find_result[:game_by_game].first.fg_pct)
    end

    def test_populates_fg3m
      assert_equal 40, find_result[:game_by_game].first.fg3m
    end

    def test_populates_fg3a
      assert_equal 100, find_result[:game_by_game].first.fg3a
    end

    def test_populates_fg3_pct
      assert_in_delta(0.400, find_result[:game_by_game].first.fg3_pct)
    end

    def test_populates_ftm
      assert_equal 80, find_result[:game_by_game].first.ftm
    end

    def test_populates_fta
      assert_equal 90, find_result[:game_by_game].first.fta
    end

    def test_populates_ft_pct
      assert_in_delta(0.889, find_result[:game_by_game].first.ft_pct)
    end
  end

  class CumeStatsTeamPopulatesPlayerOtherTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_oreb
      assert_equal 10, find_result[:game_by_game].first.oreb
    end

    def test_populates_dreb
      assert_equal 50, find_result[:game_by_game].first.dreb
    end

    def test_populates_tot_reb
      assert_equal 60, find_result[:game_by_game].first.tot_reb
    end

    def test_populates_ast
      assert_equal 70, find_result[:game_by_game].first.ast
    end

    def test_populates_pf
      assert_equal 20, find_result[:game_by_game].first.pf
    end

    def test_populates_stl
      assert_equal 15, find_result[:game_by_game].first.stl
    end

    def test_populates_tov
      assert_equal 25, find_result[:game_by_game].first.tov
    end

    def test_populates_blk
      assert_equal 5, find_result[:game_by_game].first.blk
    end

    def test_populates_pts
      assert_equal 280, find_result[:game_by_game].first.pts
    end
  end

  class CumeStatsTeamPopulatesPlayerAvgTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_avg_minutes
      assert_in_delta(35.0, find_result[:game_by_game].first.avg_minutes)
    end

    def test_populates_fgm_pg
      assert_in_delta(10.0, find_result[:game_by_game].first.fgm_pg)
    end

    def test_populates_fga_pg
      assert_in_delta(20.0, find_result[:game_by_game].first.fga_pg)
    end

    def test_populates_fg3m_pg
      assert_in_delta(4.0, find_result[:game_by_game].first.fg3m_pg)
    end

    def test_populates_fg3a_pg
      assert_in_delta(10.0, find_result[:game_by_game].first.fg3a_pg)
    end

    def test_populates_ftm_pg
      assert_in_delta(8.0, find_result[:game_by_game].first.ftm_pg)
    end

    def test_populates_fta_pg
      assert_in_delta(9.0, find_result[:game_by_game].first.fta_pg)
    end

    def test_populates_oreb_pg
      assert_in_delta(1.0, find_result[:game_by_game].first.oreb_pg)
    end

    def test_populates_dreb_pg
      assert_in_delta(5.0, find_result[:game_by_game].first.dreb_pg)
    end

    def test_populates_reb_pg
      assert_in_delta(6.0, find_result[:game_by_game].first.reb_pg)
    end

    def test_populates_ast_pg
      assert_in_delta(7.0, find_result[:game_by_game].first.ast_pg)
    end

    def test_populates_pf_pg
      assert_in_delta(2.0, find_result[:game_by_game].first.pf_pg)
    end

    def test_populates_stl_pg
      assert_in_delta(1.5, find_result[:game_by_game].first.stl_pg)
    end

    def test_populates_tov_pg
      assert_in_delta(2.5, find_result[:game_by_game].first.tov_pg)
    end

    def test_populates_blk_pg
      assert_in_delta(0.5, find_result[:game_by_game].first.blk_pg)
    end

    def test_populates_pts_pg
      assert_in_delta(28.0, find_result[:game_by_game].first.pts_pg)
    end
  end

  class CumeStatsTeamPopulatesPlayerPerMinTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_fgm_per_min
      assert_in_delta(0.286, find_result[:game_by_game].first.fgm_per_min)
    end

    def test_populates_fga_per_min
      assert_in_delta(0.571, find_result[:game_by_game].first.fga_per_min)
    end

    def test_populates_fg3m_per_min
      assert_in_delta(0.114, find_result[:game_by_game].first.fg3m_per_min)
    end

    def test_populates_fg3a_per_min
      assert_in_delta(0.286, find_result[:game_by_game].first.fg3a_per_min)
    end

    def test_populates_ftm_per_min
      assert_in_delta(0.229, find_result[:game_by_game].first.ftm_per_min)
    end

    def test_populates_fta_per_min
      assert_in_delta(0.257, find_result[:game_by_game].first.fta_per_min)
    end

    def test_populates_oreb_per_min
      assert_in_delta(0.029, find_result[:game_by_game].first.oreb_per_min)
    end

    def test_populates_dreb_per_min
      assert_in_delta(0.143, find_result[:game_by_game].first.dreb_per_min)
    end

    def test_populates_reb_per_min
      assert_in_delta(0.171, find_result[:game_by_game].first.reb_per_min)
    end

    def test_populates_ast_per_min
      assert_in_delta(0.200, find_result[:game_by_game].first.ast_per_min)
    end

    def test_populates_pf_per_min
      assert_in_delta(0.057, find_result[:game_by_game].first.pf_per_min)
    end

    def test_populates_stl_per_min
      assert_in_delta(0.043, find_result[:game_by_game].first.stl_per_min)
    end

    def test_populates_tov_per_min
      assert_in_delta(0.071, find_result[:game_by_game].first.tov_per_min)
    end

    def test_populates_blk_per_min
      assert_in_delta(0.014, find_result[:game_by_game].first.blk_per_min)
    end

    def test_populates_pts_per_min
      assert_in_delta(0.800, find_result[:game_by_game].first.pts_per_min)
    end
  end

  class CumeStatsTeamPopulatesTotalRecordTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_gp
      assert_equal 10, find_result[:total].gp
    end

    def test_populates_gs
      assert_equal 10, find_result[:total].gs
    end

    def test_populates_w
      assert_equal 8, find_result[:total].w
    end

    def test_populates_l
      assert_equal 2, find_result[:total].l
    end

    def test_populates_w_home
      assert_equal 5, find_result[:total].w_home
    end

    def test_populates_l_home
      assert_equal 1, find_result[:total].l_home
    end

    def test_populates_w_road
      assert_equal 3, find_result[:total].w_road
    end

    def test_populates_l_road
      assert_equal 1, find_result[:total].l_road
    end

    def test_populates_team_turnovers
      assert_equal 120, find_result[:total].team_turnovers
    end

    def test_populates_team_rebounds
      assert_equal 450, find_result[:total].team_rebounds
    end
  end

  class CumeStatsTeamPopulatesTotalShotTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_fgm
      assert_equal 400, find_result[:total].fgm
    end

    def test_populates_fga
      assert_equal 850, find_result[:total].fga
    end

    def test_populates_fg_pct
      assert_in_delta(0.471, find_result[:total].fg_pct)
    end

    def test_populates_fg3m
      assert_equal 150, find_result[:total].fg3m
    end

    def test_populates_fg3a
      assert_equal 400, find_result[:total].fg3a
    end

    def test_populates_fg3_pct
      assert_in_delta(0.375, find_result[:total].fg3_pct)
    end

    def test_populates_ftm
      assert_equal 180, find_result[:total].ftm
    end

    def test_populates_fta
      assert_equal 220, find_result[:total].fta
    end

    def test_populates_ft_pct
      assert_in_delta(0.818, find_result[:total].ft_pct)
    end
  end

  class CumeStatsTeamPopulatesTotalOtherTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_oreb
      assert_equal 100, find_result[:total].oreb
    end

    def test_populates_dreb
      assert_equal 350, find_result[:total].dreb
    end

    def test_populates_tot_reb
      assert_equal 450, find_result[:total].tot_reb
    end

    def test_populates_ast
      assert_equal 250, find_result[:total].ast
    end

    def test_populates_pf
      assert_equal 180, find_result[:total].pf
    end

    def test_populates_stl
      assert_equal 80, find_result[:total].stl
    end

    def test_populates_tov
      assert_equal 120, find_result[:total].tov
    end

    def test_populates_blk
      assert_equal 45, find_result[:total].blk
    end

    def test_populates_pts
      assert_equal 1130, find_result[:total].pts
    end
  end
end
