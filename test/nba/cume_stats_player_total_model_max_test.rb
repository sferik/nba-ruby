require_relative "../test_helper"

module NBA
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
