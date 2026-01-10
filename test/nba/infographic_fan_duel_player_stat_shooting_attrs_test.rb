require_relative "../test_helper"

module NBA
  class InfographicFanDuelPlayerStatShootingAttrsTest < Minitest::Test
    cover InfographicFanDuelPlayerStat

    def test_fgm_attribute
      stat = InfographicFanDuelPlayerStat.new(fgm: 10)

      assert_equal 10, stat.fgm
    end

    def test_fga_attribute
      stat = InfographicFanDuelPlayerStat.new(fga: 20)

      assert_equal 20, stat.fga
    end

    def test_fg_pct_attribute
      stat = InfographicFanDuelPlayerStat.new(fg_pct: 0.500)

      assert_in_delta 0.500, stat.fg_pct, 0.001
    end

    def test_fg3m_attribute
      stat = InfographicFanDuelPlayerStat.new(fg3m: 5)

      assert_equal 5, stat.fg3m
    end

    def test_fg3a_attribute
      stat = InfographicFanDuelPlayerStat.new(fg3a: 11)

      assert_equal 11, stat.fg3a
    end

    def test_fg3_pct_attribute
      stat = InfographicFanDuelPlayerStat.new(fg3_pct: 0.455)

      assert_in_delta 0.455, stat.fg3_pct, 0.001
    end

    def test_ftm_attribute
      stat = InfographicFanDuelPlayerStat.new(ftm: 5)

      assert_equal 5, stat.ftm
    end

    def test_fta_attribute
      stat = InfographicFanDuelPlayerStat.new(fta: 6)

      assert_equal 6, stat.fta
    end

    def test_ft_pct_attribute
      stat = InfographicFanDuelPlayerStat.new(ft_pct: 0.833)

      assert_in_delta 0.833, stat.ft_pct, 0.001
    end
  end
end
