require_relative "../test_helper"

module NBA
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
end
