require_relative "../test_helper"

module NBA
  class CareerStatsAttributesTest < Minitest::Test
    cover CareerStats

    def test_team_attributes
      stats = CareerStats.new(team_id: Team::GSW, team_abbreviation: "GSW")

      assert_equal Team::GSW, stats.team_id
      assert_equal "GSW", stats.team_abbreviation
    end

    def test_games_attributes
      stats = CareerStats.new(player_age: 36, gp: 74, gs: 74, min: 32.7)

      assert_equal 36, stats.player_age
      assert_equal 74, stats.gp
      assert_equal 74, stats.gs
      assert_in_delta 32.7, stats.min
    end

    def test_shooting_attributes
      stats = CareerStats.new(fgm: 8.4, fga: 17.9, fg_pct: 0.473, pts: 26.4)

      assert_in_delta 8.4, stats.fgm
      assert_in_delta 17.9, stats.fga
      assert_in_delta 0.473, stats.fg_pct
      assert_in_delta 26.4, stats.pts
    end

    def test_three_point_attributes
      stats = CareerStats.new(fg3m: 4.8, fg3a: 11.7, fg3_pct: 0.408)

      assert_in_delta 4.8, stats.fg3m
      assert_in_delta 11.7, stats.fg3a
      assert_in_delta 0.408, stats.fg3_pct
    end

    def test_free_throw_attributes
      stats = CareerStats.new(ftm: 4.5, fta: 4.9, ft_pct: 0.915)

      assert_in_delta 4.5, stats.ftm
      assert_in_delta 4.9, stats.fta
      assert_in_delta 0.915, stats.ft_pct
    end

    def test_rebound_attributes
      stats = CareerStats.new(oreb: 0.5, dreb: 4.0, reb: 4.5)

      assert_in_delta 0.5, stats.oreb
      assert_in_delta 4.0, stats.dreb
      assert_in_delta 4.5, stats.reb
    end

    def test_other_counting_stats
      stats = CareerStats.new(ast: 5.1, stl: 0.7, blk: 0.4, tov: 3.0, pf: 1.8)

      assert_in_delta 5.1, stats.ast
      assert_in_delta 0.7, stats.stl
      assert_in_delta 0.4, stats.blk
      assert_in_delta 3.0, stats.tov
      assert_in_delta 1.8, stats.pf
    end
  end
end
