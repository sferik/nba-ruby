require_relative "../test_helper"

module NBA
  class CumeStatsPlayerGameModelOtherTest < Minitest::Test
    cover CumeStatsPlayerGame

    def test_has_oreb_attribute
      game = CumeStatsPlayerGame.new(oreb: 2)

      assert_equal 2, game.oreb
    end

    def test_has_dreb_attribute
      game = CumeStatsPlayerGame.new(dreb: 6)

      assert_equal 6, game.dreb
    end

    def test_has_reb_attribute
      game = CumeStatsPlayerGame.new(reb: 8)

      assert_equal 8, game.reb
    end

    def test_has_ast_attribute
      game = CumeStatsPlayerGame.new(ast: 5)

      assert_equal 5, game.ast
    end

    def test_has_pf_attribute
      game = CumeStatsPlayerGame.new(pf: 3)

      assert_equal 3, game.pf
    end

    def test_has_stl_attribute
      game = CumeStatsPlayerGame.new(stl: 2)

      assert_equal 2, game.stl
    end

    def test_has_tov_attribute
      game = CumeStatsPlayerGame.new(tov: 3)

      assert_equal 3, game.tov
    end

    def test_has_blk_attribute
      game = CumeStatsPlayerGame.new(blk: 1)

      assert_equal 1, game.blk
    end

    def test_has_pts_attribute
      game = CumeStatsPlayerGame.new(pts: 30)

      assert_equal 30, game.pts
    end
  end
end
