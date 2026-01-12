require_relative "../../test_helper"

module NBA
  class InfographicFanDuelPlayerStatCountingAttrsTest < Minitest::Test
    cover InfographicFanDuelPlayerStat

    def test_oreb_attribute
      stat = InfographicFanDuelPlayerStat.new(oreb: 1)

      assert_equal 1, stat.oreb
    end

    def test_dreb_attribute
      stat = InfographicFanDuelPlayerStat.new(dreb: 5)

      assert_equal 5, stat.dreb
    end

    def test_reb_attribute
      stat = InfographicFanDuelPlayerStat.new(reb: 6)

      assert_equal 6, stat.reb
    end

    def test_ast_attribute
      stat = InfographicFanDuelPlayerStat.new(ast: 8)

      assert_equal 8, stat.ast
    end

    def test_tov_attribute
      stat = InfographicFanDuelPlayerStat.new(tov: 3)

      assert_equal 3, stat.tov
    end

    def test_stl_attribute
      stat = InfographicFanDuelPlayerStat.new(stl: 2)

      assert_equal 2, stat.stl
    end

    def test_blk_attribute
      stat = InfographicFanDuelPlayerStat.new(blk: 0)

      assert_equal 0, stat.blk
    end

    def test_blka_attribute
      stat = InfographicFanDuelPlayerStat.new(blka: 1)

      assert_equal 1, stat.blka
    end

    def test_pf_attribute
      stat = InfographicFanDuelPlayerStat.new(pf: 2)

      assert_equal 2, stat.pf
    end

    def test_pfd_attribute
      stat = InfographicFanDuelPlayerStat.new(pfd: 4)

      assert_equal 4, stat.pfd
    end

    def test_pts_attribute
      stat = InfographicFanDuelPlayerStat.new(pts: 30)

      assert_equal 30, stat.pts
    end

    def test_plus_minus_attribute
      stat = InfographicFanDuelPlayerStat.new(plus_minus: 15)

      assert_equal 15, stat.plus_minus
    end

    def test_plus_minus_attribute_negative
      stat = InfographicFanDuelPlayerStat.new(plus_minus: -10)

      assert_equal(-10, stat.plus_minus)
    end
  end
end
