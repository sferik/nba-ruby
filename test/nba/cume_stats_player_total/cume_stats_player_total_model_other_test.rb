require_relative "../../test_helper"

module NBA
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
end
