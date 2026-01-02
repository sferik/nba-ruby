require_relative "../test_helper"

module NBA
  class ShotTest < Minitest::Test
    cover Shot

    def test_objects_with_same_game_id_and_event_id_are_equal
      shot0 = Shot.new(game_id: "001", game_event_id: 1)
      shot1 = Shot.new(game_id: "001", game_event_id: 1)

      assert_equal shot0, shot1
    end

    def test_objects_with_different_event_id_are_not_equal
      shot0 = Shot.new(game_id: "001", game_event_id: 1)
      shot1 = Shot.new(game_id: "001", game_event_id: 2)

      refute_equal shot0, shot1
    end

    def test_made_returns_true_when_shot_made_flag_is_one
      shot = Shot.new(shot_made_flag: 1)

      assert_predicate shot, :made?
    end

    def test_made_returns_false_when_shot_made_flag_is_zero
      shot = Shot.new(shot_made_flag: 0)

      refute_predicate shot, :made?
    end

    def test_missed_returns_true_when_shot_made_flag_is_zero
      shot = Shot.new(shot_made_flag: 0)

      assert_predicate shot, :missed?
    end

    def test_missed_returns_false_when_shot_made_flag_is_one
      shot = Shot.new(shot_made_flag: 1)

      refute_predicate shot, :missed?
    end

    def test_three_pointer_returns_true_for_3pt_shot
      shot = Shot.new(shot_type: "3PT Field Goal")

      assert_predicate shot, :three_pointer?
    end

    def test_three_pointer_returns_false_for_2pt_shot
      shot = Shot.new(shot_type: "2PT Field Goal")

      refute_predicate shot, :three_pointer?
    end

    def test_three_pointer_returns_false_when_shot_type_nil
      shot = Shot.new(shot_type: nil)

      refute_predicate shot, :three_pointer?
    end
  end
end
