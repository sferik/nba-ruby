require_relative "../test_helper"

module NBA
  class LeagueWideShotStatTest < Minitest::Test
    cover LeagueWideShotStat

    def test_equality_based_on_zone_attributes
      stat1 = LeagueWideShotStat.new(shot_zone_basic: "Restricted Area", shot_zone_area: "Center(C)", shot_zone_range: "Less Than 8 ft.")
      stat2 = LeagueWideShotStat.new(shot_zone_basic: "Restricted Area", shot_zone_area: "Center(C)", shot_zone_range: "Less Than 8 ft.")
      stat3 = LeagueWideShotStat.new(shot_zone_basic: "Mid-Range", shot_zone_area: "Center(C)", shot_zone_range: "Less Than 8 ft.")
      stat4 = LeagueWideShotStat.new(shot_zone_basic: "Restricted Area", shot_zone_area: "Left Side(L)", shot_zone_range: "Less Than 8 ft.")
      stat5 = LeagueWideShotStat.new(shot_zone_basic: "Restricted Area", shot_zone_area: "Center(C)", shot_zone_range: "8-16 ft.")

      assert_equal stat1, stat2
      refute_equal stat1, stat3
      refute_equal stat1, stat4
      refute_equal stat1, stat5
    end

    def test_zone_attributes_assignable
      stat = build_stat

      assert_equal "Shot Zone Basic", stat.grid_type
      assert_equal "Restricted Area", stat.shot_zone_basic
      assert_equal "Center(C)", stat.shot_zone_area
      assert_equal "Less Than 8 ft.", stat.shot_zone_range
    end

    def test_shooting_attributes_assignable
      stat = build_stat

      assert_equal 50_000, stat.fga
      assert_equal 32_500, stat.fgm
      assert_in_delta 0.650, stat.fg_pct
    end

    private

    def build_stat
      LeagueWideShotStat.new(
        grid_type: "Shot Zone Basic",
        shot_zone_basic: "Restricted Area",
        shot_zone_area: "Center(C)",
        shot_zone_range: "Less Than 8 ft.",
        fga: 50_000,
        fgm: 32_500,
        fg_pct: 0.650
      )
    end
  end
end
