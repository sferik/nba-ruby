require_relative "../../test_helper"

module NBA
  class TeamGameLogStatCountingAttrsTest < Minitest::Test
    cover TeamGameLogStat

    def test_ftm_attribute
      log = TeamGameLogStat.new(ftm: 19)

      assert_equal 19, log.ftm
    end

    def test_fta_attribute
      log = TeamGameLogStat.new(fta: 22)

      assert_equal 22, log.fta
    end

    def test_ft_pct_attribute
      log = TeamGameLogStat.new(ft_pct: 0.864)

      assert_in_delta 0.864, log.ft_pct
    end

    def test_oreb_attribute
      log = TeamGameLogStat.new(oreb: 10)

      assert_equal 10, log.oreb
    end

    def test_dreb_attribute
      log = TeamGameLogStat.new(dreb: 35)

      assert_equal 35, log.dreb
    end

    def test_reb_attribute
      log = TeamGameLogStat.new(reb: 45)

      assert_equal 45, log.reb
    end

    def test_ast_attribute
      log = TeamGameLogStat.new(ast: 28)

      assert_equal 28, log.ast
    end

    def test_stl_attribute
      log = TeamGameLogStat.new(stl: 9)

      assert_equal 9, log.stl
    end

    def test_blk_attribute
      log = TeamGameLogStat.new(blk: 6)

      assert_equal 6, log.blk
    end

    def test_tov_attribute
      log = TeamGameLogStat.new(tov: 14)

      assert_equal 14, log.tov
    end

    def test_pf_attribute
      log = TeamGameLogStat.new(pf: 20)

      assert_equal 20, log.pf
    end

    def test_pts_attribute
      log = TeamGameLogStat.new(pts: 118)

      assert_equal 118, log.pts
    end

    def test_plus_minus_attribute
      log = TeamGameLogStat.new(plus_minus: 9)

      assert_equal 9, log.plus_minus
    end
  end
end
