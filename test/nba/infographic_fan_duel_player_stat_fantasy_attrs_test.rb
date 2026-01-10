require_relative "../test_helper"

module NBA
  class InfographicFanDuelPlayerStatFantasyAttrsTest < Minitest::Test
    cover InfographicFanDuelPlayerStat

    def test_fan_duel_pts_attribute
      stat = InfographicFanDuelPlayerStat.new(fan_duel_pts: 52.3)

      assert_in_delta 52.3, stat.fan_duel_pts, 0.01
    end

    def test_nba_fantasy_pts_attribute
      stat = InfographicFanDuelPlayerStat.new(nba_fantasy_pts: 48.5)

      assert_in_delta 48.5, stat.nba_fantasy_pts, 0.01
    end

    def test_usg_pct_attribute
      stat = InfographicFanDuelPlayerStat.new(usg_pct: 0.312)

      assert_in_delta 0.312, stat.usg_pct, 0.001
    end

    def test_min_attribute
      stat = InfographicFanDuelPlayerStat.new(min: 34.5)

      assert_in_delta 34.5, stat.min, 0.01
    end
  end
end
