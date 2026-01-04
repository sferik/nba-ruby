require_relative "../test_helper"

module NBA
  class FoundGameTest < Minitest::Test # rubocop:disable Metrics/ClassLength
    cover FoundGame

    def test_equality_based_on_game_id
      game1 = FoundGame.new(game_id: "0022400001")
      game2 = FoundGame.new(game_id: "0022400001")
      game3 = FoundGame.new(game_id: "0022400002")

      assert_equal game1, game2
      refute_equal game1, game3
    end

    def test_team_returns_team_object
      game = FoundGame.new(team_id: Team::GSW)

      team = game.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_win_returns_true_when_wl_is_w
      game = FoundGame.new(wl: "W")

      assert_predicate game, :win?
      refute_predicate game, :loss?
    end

    def test_loss_returns_true_when_wl_is_l
      game = FoundGame.new(wl: "L")

      assert_predicate game, :loss?
      refute_predicate game, :win?
    end

    def test_identity_attributes
      game = sample_game

      assert_equal "0022400001", game.game_id
      assert_equal Team::GSW, game.team_id
      assert_equal "GSW", game.team_abbreviation
      assert_equal "Warriors", game.team_name
    end

    def test_game_info
      game = sample_game

      assert_equal "2024-10-22", game.game_date
      assert_equal "GSW vs. LAL", game.matchup
      assert_equal "W", game.wl
    end

    def test_shooting_stats
      game = sample_game

      assert_equal 42, game.fgm
      assert_equal 88, game.fga
      assert_in_delta 0.477, game.fg_pct
      assert_equal 15, game.fg3m
      assert_equal 38, game.fg3a
    end

    def test_shooting_percentages
      game = sample_game

      assert_in_delta 0.395, game.fg3_pct
      assert_equal 13, game.ftm
      assert_equal 16, game.fta
      assert_in_delta 0.813, game.ft_pct
    end

    def test_counting_stats
      game = sample_game

      assert_equal 45, game.reb
      assert_equal 28, game.ast
      assert_equal 8, game.stl
      assert_equal 5, game.blk
      assert_equal 12, game.tov
    end

    def test_additional_stats
      game = sample_game

      assert_equal 18, game.pf
      assert_equal 112, game.pts
      assert_equal 240, game.min
      assert_equal "22024", game.season_id
    end

    def test_rebounding_breakdown
      game = sample_game

      assert_equal 10, game.oreb
      assert_equal 35, game.dreb
      assert_equal 45, game.reb
    end

    def test_plus_minus
      game = sample_game

      assert_equal 4, game.plus_minus
    end

    private

    def sample_game # rubocop:disable Metrics/MethodLength
      FoundGame.new(
        season_id: "22024",
        team_id: Team::GSW,
        team_abbreviation: "GSW",
        team_name: "Warriors",
        game_id: "0022400001",
        game_date: "2024-10-22",
        matchup: "GSW vs. LAL",
        wl: "W",
        min: 240,
        pts: 112,
        fgm: 42,
        fga: 88,
        fg_pct: 0.477,
        fg3m: 15,
        fg3a: 38,
        fg3_pct: 0.395,
        ftm: 13,
        fta: 16,
        ft_pct: 0.813,
        oreb: 10,
        dreb: 35,
        reb: 45,
        ast: 28,
        stl: 8,
        blk: 5,
        tov: 12,
        pf: 18,
        plus_minus: 4
      )
    end
  end
end
