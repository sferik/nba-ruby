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
end
