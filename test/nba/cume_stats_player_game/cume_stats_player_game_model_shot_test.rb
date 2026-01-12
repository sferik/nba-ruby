require_relative "../../test_helper"

module NBA
  class CumeStatsPlayerGameModelShotTest < Minitest::Test
    cover CumeStatsPlayerGame

    def test_has_fgm_attribute
      game = CumeStatsPlayerGame.new(fgm: 10)

      assert_equal 10, game.fgm
    end

    def test_has_fga_attribute
      game = CumeStatsPlayerGame.new(fga: 20)

      assert_equal 20, game.fga
    end

    def test_has_fg_pct_attribute
      game = CumeStatsPlayerGame.new(fg_pct: 0.500)

      assert_in_delta(0.500, game.fg_pct)
    end

    def test_has_fg3m_attribute
      game = CumeStatsPlayerGame.new(fg3m: 3)

      assert_equal 3, game.fg3m
    end

    def test_has_fg3a_attribute
      game = CumeStatsPlayerGame.new(fg3a: 8)

      assert_equal 8, game.fg3a
    end

    def test_has_fg3_pct_attribute
      game = CumeStatsPlayerGame.new(fg3_pct: 0.375)

      assert_in_delta(0.375, game.fg3_pct)
    end

    def test_has_ftm_attribute
      game = CumeStatsPlayerGame.new(ftm: 7)

      assert_equal 7, game.ftm
    end

    def test_has_fta_attribute
      game = CumeStatsPlayerGame.new(fta: 8)

      assert_equal 8, game.fta
    end

    def test_has_ft_pct_attribute
      game = CumeStatsPlayerGame.new(ft_pct: 0.875)

      assert_in_delta(0.875, game.ft_pct)
    end
  end
end
