require_relative "../test_helper"

module NBA
  class LiveGameTest < Minitest::Test
    cover LiveGame

    def test_equality_based_on_game_id
      game1 = LiveGame.new(game_id: "0022400001")
      game2 = LiveGame.new(game_id: "0022400001")
      game3 = LiveGame.new(game_id: "0022400002")

      assert_equal game1, game2
      refute_equal game1, game3
    end

    def test_home_team_returns_team_object
      game = LiveGame.new(home_team_id: Team::GSW)

      assert_equal Team::GSW, game.home_team.id
    end

    def test_away_team_returns_team_object
      game = LiveGame.new(away_team_id: Team::LAL)

      assert_equal Team::LAL, game.away_team.id
    end

    def test_scheduled_when_status_is_one
      game = LiveGame.new(game_status: 1)

      assert_predicate game, :scheduled?
      refute_predicate game, :in_progress?
      refute_predicate game, :final?
    end

    def test_in_progress_when_status_is_two
      game = LiveGame.new(game_status: 2)

      refute_predicate game, :scheduled?
      assert_predicate game, :in_progress?
      refute_predicate game, :final?
    end

    def test_final_when_status_is_three
      game = LiveGame.new(game_status: 3)

      refute_predicate game, :scheduled?
      refute_predicate game, :in_progress?
      assert_predicate game, :final?
    end

    def test_game_attributes
      game = LiveGame.new(game_id: "0022400001", game_code: "20241022/LALGSW",
        game_status: 2, game_status_text: "Q4 2:30", period: 4)

      assert_equal "0022400001", game.game_id
      assert_equal "20241022/LALGSW", game.game_code
      assert_equal 2, game.game_status
      assert_equal "Q4 2:30", game.game_status_text
      assert_equal 4, game.period
    end

    def test_time_attributes
      game = LiveGame.new(game_time_utc: "2024-10-22T23:30:00Z", game_et: "2024-10-22T19:30:00",
        game_clock: "PT02M30.00S")

      assert_equal "2024-10-22T23:30:00Z", game.game_time_utc
      assert_equal "2024-10-22T19:30:00", game.game_et
      assert_equal "PT02M30.00S", game.game_clock
    end

    def test_home_team_attributes
      game = LiveGame.new(home_team_id: Team::GSW, home_team_name: "Warriors",
        home_team_city: "Golden State", home_team_tricode: "GSW", home_team_score: 112)

      assert_equal Team::GSW, game.home_team_id
      assert_equal "Warriors", game.home_team_name
      assert_equal "Golden State", game.home_team_city
      assert_equal "GSW", game.home_team_tricode
      assert_equal 112, game.home_team_score
    end

    def test_away_team_attributes
      game = LiveGame.new(away_team_id: Team::LAL, away_team_name: "Lakers",
        away_team_city: "Los Angeles", away_team_tricode: "LAL", away_team_score: 108)

      assert_equal Team::LAL, game.away_team_id
      assert_equal "Lakers", game.away_team_name
      assert_equal "Los Angeles", game.away_team_city
      assert_equal "LAL", game.away_team_tricode
      assert_equal 108, game.away_team_score
    end

    def test_status_returns_game_status_text
      game = LiveGame.new(game_status_text: "Q4 2:30")

      assert_equal "Q4 2:30", game.status
    end

    def test_home_score_returns_home_team_score
      game = LiveGame.new(home_team_score: 112)

      assert_equal 112, game.home_score
    end

    def test_away_score_returns_away_team_score
      game = LiveGame.new(away_team_score: 108)

      assert_equal 108, game.away_score
    end
  end
end
