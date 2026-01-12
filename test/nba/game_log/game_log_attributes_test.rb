require_relative "../../test_helper"

module NBA
  class GameLogAttributesTest < Minitest::Test
    cover GameLog

    def test_season_id_attribute
      log = GameLog.new(season_id: "22024")

      assert_equal "22024", log.season_id
    end

    def test_game_date_attribute
      log = GameLog.new(game_date: "OCT 22, 2024")

      assert_equal "OCT 22, 2024", log.game_date
    end

    def test_matchup_attribute
      log = GameLog.new(matchup: "GSW vs. LAL")

      assert_equal "GSW vs. LAL", log.matchup
    end

    def test_minutes_attribute
      log = GameLog.new(min: 36)

      assert_equal 36, log.min
    end

    def test_scoring_attributes
      log = GameLog.new(fgm: 10, fga: 20, fg_pct: 0.5, pts: 30)

      assert_equal 10, log.fgm
      assert_equal 20, log.fga
      assert_in_delta 0.5, log.fg_pct
      assert_equal 30, log.pts
    end

    def test_three_point_attributes
      log = GameLog.new(fg3m: 4, fg3a: 10, fg3_pct: 0.4)

      assert_equal 4, log.fg3m
      assert_equal 10, log.fg3a
      assert_in_delta 0.4, log.fg3_pct
    end

    def test_free_throw_attributes
      log = GameLog.new(ftm: 5, fta: 6, ft_pct: 0.833)

      assert_equal 5, log.ftm
      assert_equal 6, log.fta
      assert_in_delta 0.833, log.ft_pct
    end

    def test_rebound_attributes
      log = GameLog.new(oreb: 2, dreb: 5, reb: 7)

      assert_equal 2, log.oreb
      assert_equal 5, log.dreb
      assert_equal 7, log.reb
    end

    def test_other_counting_stats
      log = GameLog.new(ast: 10, stl: 2, blk: 1, tov: 3, pf: 2)

      assert_equal 10, log.ast
      assert_equal 2, log.stl
      assert_equal 1, log.blk
      assert_equal 3, log.tov
      assert_equal 2, log.pf
    end

    def test_plus_minus_attribute
      log = GameLog.new(plus_minus: 12)

      assert_equal 12, log.plus_minus
    end
  end
end
