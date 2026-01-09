require_relative "../test_helper"

module NBA
  class CumeStatsPlayerGameModelBasicTest < Minitest::Test
    cover CumeStatsPlayerGame

    def test_equality_based_on_game_id
      game1 = CumeStatsPlayerGame.new(game_id: "0022400001")
      game2 = CumeStatsPlayerGame.new(game_id: "0022400001")
      game3 = CumeStatsPlayerGame.new(game_id: "0022400002")

      assert_equal game1, game2
      refute_equal game1, game3
    end

    def test_has_game_id_attribute
      game = CumeStatsPlayerGame.new(game_id: "0022400001")

      assert_equal "0022400001", game.game_id
    end

    def test_has_matchup_attribute
      game = CumeStatsPlayerGame.new(matchup: "GSW vs. LAL")

      assert_equal "GSW vs. LAL", game.matchup
    end

    def test_has_game_date_attribute
      game = CumeStatsPlayerGame.new(game_date: "2024-10-22")

      assert_equal "2024-10-22", game.game_date
    end

    def test_has_vs_team_id_attribute
      game = CumeStatsPlayerGame.new(vs_team_id: 1_610_612_747)

      assert_equal 1_610_612_747, game.vs_team_id
    end

    def test_has_vs_team_city_attribute
      game = CumeStatsPlayerGame.new(vs_team_city: "Los Angeles")

      assert_equal "Los Angeles", game.vs_team_city
    end

    def test_has_vs_team_name_attribute
      game = CumeStatsPlayerGame.new(vs_team_name: "Lakers")

      assert_equal "Lakers", game.vs_team_name
    end

    def test_has_min_attribute
      game = CumeStatsPlayerGame.new(min: 35)

      assert_equal 35, game.min
    end

    def test_has_sec_attribute
      game = CumeStatsPlayerGame.new(sec: 42)

      assert_equal 42, game.sec
    end
  end

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

  class CumeStatsPlayerGameModelOtherTest < Minitest::Test
    cover CumeStatsPlayerGame

    def test_has_oreb_attribute
      game = CumeStatsPlayerGame.new(oreb: 2)

      assert_equal 2, game.oreb
    end

    def test_has_dreb_attribute
      game = CumeStatsPlayerGame.new(dreb: 6)

      assert_equal 6, game.dreb
    end

    def test_has_reb_attribute
      game = CumeStatsPlayerGame.new(reb: 8)

      assert_equal 8, game.reb
    end

    def test_has_ast_attribute
      game = CumeStatsPlayerGame.new(ast: 5)

      assert_equal 5, game.ast
    end

    def test_has_pf_attribute
      game = CumeStatsPlayerGame.new(pf: 3)

      assert_equal 3, game.pf
    end

    def test_has_stl_attribute
      game = CumeStatsPlayerGame.new(stl: 2)

      assert_equal 2, game.stl
    end

    def test_has_tov_attribute
      game = CumeStatsPlayerGame.new(tov: 3)

      assert_equal 3, game.tov
    end

    def test_has_blk_attribute
      game = CumeStatsPlayerGame.new(blk: 1)

      assert_equal 1, game.blk
    end

    def test_has_pts_attribute
      game = CumeStatsPlayerGame.new(pts: 30)

      assert_equal 30, game.pts
    end
  end
end
