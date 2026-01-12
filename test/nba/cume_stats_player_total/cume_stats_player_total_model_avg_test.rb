require_relative "../../test_helper"

module NBA
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
end
