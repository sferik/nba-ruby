require_relative "../../test_helper"

module NBA
  class TeamGameLogEntryTest < Minitest::Test
    cover TeamGameLogEntry

    def test_objects_with_same_game_id_and_team_id_are_equal
      log0 = TeamGameLogEntry.new(game_id: "001", team_id: Team::GSW)
      log1 = TeamGameLogEntry.new(game_id: "001", team_id: Team::GSW)

      assert_equal log0, log1
    end

    def test_objects_with_different_game_id_are_not_equal
      log0 = TeamGameLogEntry.new(game_id: "001", team_id: Team::GSW)
      log1 = TeamGameLogEntry.new(game_id: "002", team_id: Team::GSW)

      refute_equal log0, log1
    end

    def test_win_returns_true_when_wl_is_w
      log = TeamGameLogEntry.new(wl: "W")

      assert_predicate log, :win?
    end

    def test_win_returns_false_when_wl_is_l
      log = TeamGameLogEntry.new(wl: "L")

      refute_predicate log, :win?
    end

    def test_loss_returns_true_when_wl_is_l
      log = TeamGameLogEntry.new(wl: "L")

      assert_predicate log, :loss?
    end

    def test_loss_returns_false_when_wl_is_w
      log = TeamGameLogEntry.new(wl: "W")

      refute_predicate log, :loss?
    end

    def test_team_returns_team_object
      log = TeamGameLogEntry.new(team_id: Team::GSW)

      team = log.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      log = TeamGameLogEntry.new(team_id: nil)

      assert_nil log.team
    end
  end
end
