require_relative "../test_helper"

module NBA
  class ShotPredicatesTest < Minitest::Test
    cover Shot

    def test_attempted_returns_true_when_shot_attempted_flag_is_one
      shot = Shot.new(shot_attempted_flag: 1)

      assert_predicate shot, :attempted?
    end

    def test_attempted_returns_false_when_shot_attempted_flag_is_zero
      shot = Shot.new(shot_attempted_flag: 0)

      refute_predicate shot, :attempted?
    end

    def test_attempted_uses_value_equality
      shot = Shot.new(shot_attempted_flag: 1.0)

      assert_predicate shot, :attempted?
    end

    def test_made_returns_true_when_shot_made_flag_is_one
      shot = Shot.new(shot_made_flag: 1)

      assert_predicate shot, :made?
    end

    def test_made_returns_false_when_shot_made_flag_is_zero
      shot = Shot.new(shot_made_flag: 0)

      refute_predicate shot, :made?
    end

    def test_made_uses_value_equality
      shot = Shot.new(shot_made_flag: 1.0)

      assert_predicate shot, :made?
    end

    def test_missed_returns_true_when_shot_made_flag_is_zero
      shot = Shot.new(shot_made_flag: 0)

      assert_predicate shot, :missed?
    end

    def test_missed_returns_false_when_shot_made_flag_is_one
      shot = Shot.new(shot_made_flag: 1)

      refute_predicate shot, :missed?
    end

    def test_missed_returns_nil_when_shot_made_flag_is_nil
      shot = Shot.new(shot_made_flag: nil)

      assert_nil shot.missed?
    end

    def test_three_pointer_returns_true_when_shot_type_includes_3pt
      shot = Shot.new(shot_type: "3PT Field Goal")

      assert_predicate shot, :three_pointer?
    end

    def test_three_pointer_returns_false_when_shot_type_is_2pt
      shot = Shot.new(shot_type: "2PT Field Goal")

      refute_predicate shot, :three_pointer?
    end

    def test_three_pointer_returns_false_when_shot_type_is_nil
      shot = Shot.new(shot_type: nil)

      refute_predicate shot, :three_pointer?
    end
  end
end
