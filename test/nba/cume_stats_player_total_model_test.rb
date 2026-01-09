require_relative "../test_helper"

module NBA
  class CumeStatsPlayerTotalModelBasicTest < Minitest::Test
    cover CumeStatsPlayerTotal

    def test_equality_based_on_player_id
      total1 = CumeStatsPlayerTotal.new(player_id: 201_939)
      total2 = CumeStatsPlayerTotal.new(player_id: 201_939)
      total3 = CumeStatsPlayerTotal.new(player_id: 201_940)

      assert_equal total1, total2
      refute_equal total1, total3
    end

    def test_has_player_id_attribute
      total = CumeStatsPlayerTotal.new(player_id: 201_939)

      assert_equal 201_939, total.player_id
    end

    def test_has_player_name_attribute
      total = CumeStatsPlayerTotal.new(player_name: "Stephen Curry")

      assert_equal "Stephen Curry", total.player_name
    end

    def test_has_jersey_num_attribute
      total = CumeStatsPlayerTotal.new(jersey_num: "30")

      assert_equal "30", total.jersey_num
    end

    def test_has_season_attribute
      total = CumeStatsPlayerTotal.new(season: "2024-25")

      assert_equal "2024-25", total.season
    end

    def test_has_gp_attribute
      total = CumeStatsPlayerTotal.new(gp: 5)

      assert_equal 5, total.gp
    end

    def test_has_gs_attribute
      total = CumeStatsPlayerTotal.new(gs: 5)

      assert_equal 5, total.gs
    end

    def test_has_actual_minutes_attribute
      total = CumeStatsPlayerTotal.new(actual_minutes: 175)

      assert_equal 175, total.actual_minutes
    end

    def test_has_actual_seconds_attribute
      total = CumeStatsPlayerTotal.new(actual_seconds: 42)

      assert_equal 42, total.actual_seconds
    end
  end

  class CumeStatsPlayerTotalModelShotTest < Minitest::Test
    cover CumeStatsPlayerTotal

    def test_has_fgm_attribute
      total = CumeStatsPlayerTotal.new(fgm: 50)

      assert_equal 50, total.fgm
    end

    def test_has_fga_attribute
      total = CumeStatsPlayerTotal.new(fga: 100)

      assert_equal 100, total.fga
    end

    def test_has_fg_pct_attribute
      total = CumeStatsPlayerTotal.new(fg_pct: 0.500)

      assert_in_delta(0.500, total.fg_pct)
    end

    def test_has_fg3m_attribute
      total = CumeStatsPlayerTotal.new(fg3m: 15)

      assert_equal 15, total.fg3m
    end

    def test_has_fg3a_attribute
      total = CumeStatsPlayerTotal.new(fg3a: 40)

      assert_equal 40, total.fg3a
    end

    def test_has_fg3_pct_attribute
      total = CumeStatsPlayerTotal.new(fg3_pct: 0.375)

      assert_in_delta(0.375, total.fg3_pct)
    end

    def test_has_ftm_attribute
      total = CumeStatsPlayerTotal.new(ftm: 35)

      assert_equal 35, total.ftm
    end

    def test_has_fta_attribute
      total = CumeStatsPlayerTotal.new(fta: 40)

      assert_equal 40, total.fta
    end

    def test_has_ft_pct_attribute
      total = CumeStatsPlayerTotal.new(ft_pct: 0.875)

      assert_in_delta(0.875, total.ft_pct)
    end
  end

  class CumeStatsPlayerTotalModelOtherTest < Minitest::Test
    cover CumeStatsPlayerTotal

    def test_has_oreb_attribute
      total = CumeStatsPlayerTotal.new(oreb: 10)

      assert_equal 10, total.oreb
    end

    def test_has_dreb_attribute
      total = CumeStatsPlayerTotal.new(dreb: 30)

      assert_equal 30, total.dreb
    end

    def test_has_tot_reb_attribute
      total = CumeStatsPlayerTotal.new(tot_reb: 40)

      assert_equal 40, total.tot_reb
    end

    def test_has_ast_attribute
      total = CumeStatsPlayerTotal.new(ast: 25)

      assert_equal 25, total.ast
    end

    def test_has_pf_attribute
      total = CumeStatsPlayerTotal.new(pf: 15)

      assert_equal 15, total.pf
    end

    def test_has_stl_attribute
      total = CumeStatsPlayerTotal.new(stl: 10)

      assert_equal 10, total.stl
    end

    def test_has_tov_attribute
      total = CumeStatsPlayerTotal.new(tov: 15)

      assert_equal 15, total.tov
    end

    def test_has_blk_attribute
      total = CumeStatsPlayerTotal.new(blk: 5)

      assert_equal 5, total.blk
    end

    def test_has_pts_attribute
      total = CumeStatsPlayerTotal.new(pts: 150)

      assert_equal 150, total.pts
    end
  end

  class CumeStatsPlayerTotalModelAvgTest < Minitest::Test
    cover CumeStatsPlayerTotal

    def test_has_avg_min_attribute
      total = CumeStatsPlayerTotal.new(avg_min: 35.0)

      assert_in_delta(35.0, total.avg_min)
    end

    def test_has_avg_sec_attribute
      total = CumeStatsPlayerTotal.new(avg_sec: 8.4)

      assert_in_delta(8.4, total.avg_sec)
    end

    def test_has_avg_fgm_attribute
      total = CumeStatsPlayerTotal.new(avg_fgm: 10.0)

      assert_in_delta(10.0, total.avg_fgm)
    end

    def test_has_avg_fga_attribute
      total = CumeStatsPlayerTotal.new(avg_fga: 20.0)

      assert_in_delta(20.0, total.avg_fga)
    end

    def test_has_avg_fg3m_attribute
      total = CumeStatsPlayerTotal.new(avg_fg3m: 3.0)

      assert_in_delta(3.0, total.avg_fg3m)
    end

    def test_has_avg_fg3a_attribute
      total = CumeStatsPlayerTotal.new(avg_fg3a: 8.0)

      assert_in_delta(8.0, total.avg_fg3a)
    end

    def test_has_avg_ftm_attribute
      total = CumeStatsPlayerTotal.new(avg_ftm: 7.0)

      assert_in_delta(7.0, total.avg_ftm)
    end

    def test_has_avg_fta_attribute
      total = CumeStatsPlayerTotal.new(avg_fta: 8.0)

      assert_in_delta(8.0, total.avg_fta)
    end

    def test_has_avg_oreb_attribute
      total = CumeStatsPlayerTotal.new(avg_oreb: 2.0)

      assert_in_delta(2.0, total.avg_oreb)
    end

    def test_has_avg_dreb_attribute
      total = CumeStatsPlayerTotal.new(avg_dreb: 6.0)

      assert_in_delta(6.0, total.avg_dreb)
    end

    def test_has_avg_tot_reb_attribute
      total = CumeStatsPlayerTotal.new(avg_tot_reb: 8.0)

      assert_in_delta(8.0, total.avg_tot_reb)
    end

    def test_has_avg_ast_attribute
      total = CumeStatsPlayerTotal.new(avg_ast: 5.0)

      assert_in_delta(5.0, total.avg_ast)
    end

    def test_has_avg_pf_attribute
      total = CumeStatsPlayerTotal.new(avg_pf: 3.0)

      assert_in_delta(3.0, total.avg_pf)
    end

    def test_has_avg_stl_attribute
      total = CumeStatsPlayerTotal.new(avg_stl: 2.0)

      assert_in_delta(2.0, total.avg_stl)
    end

    def test_has_avg_tov_attribute
      total = CumeStatsPlayerTotal.new(avg_tov: 3.0)

      assert_in_delta(3.0, total.avg_tov)
    end

    def test_has_avg_blk_attribute
      total = CumeStatsPlayerTotal.new(avg_blk: 1.0)

      assert_in_delta(1.0, total.avg_blk)
    end

    def test_has_avg_pts_attribute
      total = CumeStatsPlayerTotal.new(avg_pts: 30.0)

      assert_in_delta(30.0, total.avg_pts)
    end
  end

  class CumeStatsPlayerTotalModelMaxTest < Minitest::Test
    cover CumeStatsPlayerTotal

    def test_has_max_min_attribute
      total = CumeStatsPlayerTotal.new(max_min: 42)

      assert_equal 42, total.max_min
    end

    def test_has_max_fgm_attribute
      total = CumeStatsPlayerTotal.new(max_fgm: 15)

      assert_equal 15, total.max_fgm
    end

    def test_has_max_fga_attribute
      total = CumeStatsPlayerTotal.new(max_fga: 25)

      assert_equal 25, total.max_fga
    end

    def test_has_max_fg3m_attribute
      total = CumeStatsPlayerTotal.new(max_fg3m: 8)

      assert_equal 8, total.max_fg3m
    end

    def test_has_max_fg3a_attribute
      total = CumeStatsPlayerTotal.new(max_fg3a: 12)

      assert_equal 12, total.max_fg3a
    end

    def test_has_max_ftm_attribute
      total = CumeStatsPlayerTotal.new(max_ftm: 10)

      assert_equal 10, total.max_ftm
    end

    def test_has_max_fta_attribute
      total = CumeStatsPlayerTotal.new(max_fta: 12)

      assert_equal 12, total.max_fta
    end

    def test_has_max_oreb_attribute
      total = CumeStatsPlayerTotal.new(max_oreb: 5)

      assert_equal 5, total.max_oreb
    end

    def test_has_max_dreb_attribute
      total = CumeStatsPlayerTotal.new(max_dreb: 10)

      assert_equal 10, total.max_dreb
    end

    def test_has_max_reb_attribute
      total = CumeStatsPlayerTotal.new(max_reb: 12)

      assert_equal 12, total.max_reb
    end

    def test_has_max_ast_attribute
      total = CumeStatsPlayerTotal.new(max_ast: 10)

      assert_equal 10, total.max_ast
    end

    def test_has_max_pf_attribute
      total = CumeStatsPlayerTotal.new(max_pf: 5)

      assert_equal 5, total.max_pf
    end

    def test_has_max_stl_attribute
      total = CumeStatsPlayerTotal.new(max_stl: 4)

      assert_equal 4, total.max_stl
    end

    def test_has_max_tov_attribute
      total = CumeStatsPlayerTotal.new(max_tov: 5)

      assert_equal 5, total.max_tov
    end

    def test_has_max_blk_attribute
      total = CumeStatsPlayerTotal.new(max_blk: 3)

      assert_equal 3, total.max_blk
    end

    def test_has_max_pts_attribute
      total = CumeStatsPlayerTotal.new(max_pts: 45)

      assert_equal 45, total.max_pts
    end
  end
end
