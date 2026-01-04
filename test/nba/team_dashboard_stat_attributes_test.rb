require_relative "../test_helper"

module NBA
  class TeamDashboardStatAttributesTest < Minitest::Test
    cover TeamDashboardStat

    def test_field_goal_attributes_assignable
      stat = sample_stat

      assert_in_delta 42.5, stat.fgm
      assert_in_delta 88.2, stat.fga
      assert_in_delta 0.482, stat.fg_pct
    end

    def test_three_point_attributes_assignable
      stat = sample_stat

      assert_in_delta 14.5, stat.fg3m
      assert_in_delta 38.8, stat.fg3a
      assert_in_delta 0.374, stat.fg3_pct
    end

    def test_free_throw_attributes_assignable
      stat = sample_stat

      assert_in_delta 18.0, stat.ftm
      assert_in_delta 22.5, stat.fta
      assert_in_delta 0.800, stat.ft_pct
    end

    def test_rebound_attributes_assignable
      stat = sample_stat

      assert_in_delta 10.5, stat.oreb
      assert_in_delta 35.5, stat.dreb
      assert_in_delta 46.0, stat.reb
    end

    def test_assist_and_turnover_attributes_assignable
      stat = sample_stat

      assert_in_delta 28.5, stat.ast
      assert_in_delta 13.5, stat.tov
    end

    def test_defensive_attributes_assignable
      stat = sample_stat

      assert_in_delta 8.0, stat.stl
      assert_in_delta 5.5, stat.blk
      assert_in_delta 4.0, stat.blka
    end

    def test_foul_attributes_assignable
      stat = sample_stat

      assert_in_delta 19.0, stat.pf
      assert_in_delta 21.0, stat.pfd
    end

    def test_scoring_attributes_assignable
      stat = sample_stat

      assert_in_delta 117.5, stat.pts
      assert_in_delta 5.5, stat.plus_minus
    end

    private

    def sample_stat
      TeamDashboardStat.new(
        team_id: Team::GSW, gp: 82, w: 50, l: 32, w_pct: 0.610, min: 48.0,
        fgm: 42.5, fga: 88.2, fg_pct: 0.482, fg3m: 14.5, fg3a: 38.8, fg3_pct: 0.374,
        ftm: 18.0, fta: 22.5, ft_pct: 0.800, oreb: 10.5, dreb: 35.5, reb: 46.0,
        ast: 28.5, tov: 13.5, stl: 8.0, blk: 5.5, blka: 4.0, pf: 19.0, pfd: 21.0,
        pts: 117.5, plus_minus: 5.5
      )
    end
  end
end
