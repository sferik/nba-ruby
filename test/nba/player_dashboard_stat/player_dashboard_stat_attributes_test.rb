require_relative "../../test_helper"

module NBA
  class PlayerDashboardStatAttributesTest < Minitest::Test
    cover PlayerDashboardStat

    def test_field_goal_attributes_assignable
      stat = sample_stat

      assert_in_delta 10.5, stat.fgm
      assert_in_delta 21.2, stat.fga
      assert_in_delta 0.495, stat.fg_pct
    end

    def test_three_point_attributes_assignable
      stat = sample_stat

      assert_in_delta 5.5, stat.fg3m
      assert_in_delta 11.8, stat.fg3a
      assert_in_delta 0.466, stat.fg3_pct
    end

    def test_free_throw_attributes_assignable
      stat = sample_stat

      assert_in_delta 5.0, stat.ftm
      assert_in_delta 5.5, stat.fta
      assert_in_delta 0.909, stat.ft_pct
    end

    def test_rebound_attributes_assignable
      stat = sample_stat

      assert_in_delta 0.5, stat.oreb
      assert_in_delta 5.5, stat.dreb
      assert_in_delta 6.0, stat.reb
    end

    def test_assist_and_turnover_attributes_assignable
      stat = sample_stat

      assert_in_delta 5.5, stat.ast
      assert_in_delta 2.5, stat.tov
    end

    def test_defensive_attributes_assignable
      stat = sample_stat

      assert_in_delta 1.0, stat.stl
      assert_in_delta 0.5, stat.blk
      assert_in_delta 0.2, stat.blka
    end

    def test_foul_attributes_assignable
      stat = sample_stat

      assert_in_delta 2.0, stat.pf
      assert_in_delta 3.5, stat.pfd
    end

    def test_scoring_attributes_assignable
      stat = sample_stat

      assert_in_delta 31.5, stat.pts
      assert_in_delta 8.5, stat.plus_minus
    end

    private

    def sample_stat
      PlayerDashboardStat.new(
        player_id: 201_939, gp: 82, w: 50, l: 32, w_pct: 0.610, min: 34.5,
        fgm: 10.5, fga: 21.2, fg_pct: 0.495, fg3m: 5.5, fg3a: 11.8, fg3_pct: 0.466,
        ftm: 5.0, fta: 5.5, ft_pct: 0.909, oreb: 0.5, dreb: 5.5, reb: 6.0,
        ast: 5.5, tov: 2.5, stl: 1.0, blk: 0.5, blka: 0.2, pf: 2.0, pfd: 3.5,
        pts: 31.5, plus_minus: 8.5
      )
    end
  end
end
