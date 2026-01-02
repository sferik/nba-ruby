require_relative "../../test_helper"

module NBA
  class ScheduledGameTest < Minitest::Test
    cover ScheduledGame

    def test_objects_with_same_game_id_are_equal
      game0 = ScheduledGame.new(game_id: "0022400001")
      game1 = ScheduledGame.new(game_id: "0022400001")

      assert_equal game0, game1
    end

    def test_objects_with_different_game_id_are_not_equal
      game0 = ScheduledGame.new(game_id: "0022400001")
      game1 = ScheduledGame.new(game_id: "0022400002")

      refute_equal game0, game1
    end

    def test_scheduled_returns_true_when_status_is_scheduled
      game = ScheduledGame.new(game_status: 1)

      assert_predicate game, :scheduled?
    end

    def test_scheduled_returns_false_when_status_is_in_progress
      game = ScheduledGame.new(game_status: 2)

      refute_predicate game, :scheduled?
    end

    def test_scheduled_returns_false_when_status_is_final
      game = ScheduledGame.new(game_status: 3)

      refute_predicate game, :scheduled?
    end

    def test_in_progress_returns_true_when_status_is_in_progress
      game = ScheduledGame.new(game_status: 2)

      assert_predicate game, :in_progress?
    end

    def test_in_progress_returns_false_when_status_is_scheduled
      game = ScheduledGame.new(game_status: 1)

      refute_predicate game, :in_progress?
    end

    def test_in_progress_returns_false_when_status_is_final
      game = ScheduledGame.new(game_status: 3)

      refute_predicate game, :in_progress?
    end

    def test_final_returns_true_when_status_is_final
      game = ScheduledGame.new(game_status: 3)

      assert_predicate game, :final?
    end

    def test_final_returns_false_when_status_is_scheduled
      game = ScheduledGame.new(game_status: 1)

      refute_predicate game, :final?
    end

    def test_final_returns_false_when_status_is_in_progress
      game = ScheduledGame.new(game_status: 2)

      refute_predicate game, :final?
    end

    def test_home_team_returns_team_object
      game = ScheduledGame.new(home_team_id: Team::GSW)

      team = game.home_team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_home_team_returns_nil_when_team_id_is_nil
      game = ScheduledGame.new(home_team_id: nil)

      assert_nil game.home_team
    end

    def test_away_team_returns_team_object
      game = ScheduledGame.new(away_team_id: Team::LAL)

      team = game.away_team

      assert_instance_of Team, team
      assert_equal Team::LAL, team.id
    end

    def test_away_team_returns_nil_when_team_id_is_nil
      game = ScheduledGame.new(away_team_id: nil)

      assert_nil game.away_team
    end
  end
end
