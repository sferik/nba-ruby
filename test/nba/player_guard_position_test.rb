require_relative "../test_helper"

module NBA
  class PlayerGuardPositionTest < Minitest::Test
    cover Player

    def test_point_guard_with_abbreviation
      player = Player.new(position: Position.new(abbreviation: "PG"))

      assert_predicate player, :point_guard?
      assert_predicate player, :guard?
    end

    def test_point_guard_with_name
      player = Player.new(position: Position.new(name: "Point Guard"))

      assert_predicate player, :point_guard?
      assert_predicate player, :guard?
    end

    def test_shooting_guard_with_abbreviation
      player = Player.new(position: Position.new(abbreviation: "SG"))

      assert_predicate player, :shooting_guard?
      assert_predicate player, :guard?
    end

    def test_shooting_guard_with_name
      player = Player.new(position: Position.new(name: "Shooting Guard"))

      assert_predicate player, :shooting_guard?
      assert_predicate player, :guard?
    end

    def test_guard_with_abbreviation
      player = Player.new(position: Position.new(abbreviation: "G"))

      assert_predicate player, :guard?
      refute_predicate player, :point_guard?
      refute_predicate player, :shooting_guard?
    end

    def test_guard_with_name
      player = Player.new(position: Position.new(name: "Guard"))

      assert_predicate player, :guard?
      refute_predicate player, :point_guard?
      refute_predicate player, :shooting_guard?
    end

    def test_guard_is_not_forward_or_center
      player = Player.new(position: Position.new(abbreviation: "G"))

      refute_predicate player, :forward?
      refute_predicate player, :center?
    end

    def test_guard_returns_false_when_position_does_not_match
      player = Player.new(position: Position.new(abbreviation: "C", name: "Center"))

      refute_predicate player, :point_guard?
      refute_predicate player, :shooting_guard?
      refute_predicate player, :guard?
    end

    def test_guard_returns_false_when_position_is_nil
      player = Player.new(position: nil)

      refute_predicate player, :point_guard?
      refute_predicate player, :shooting_guard?
      refute_predicate player, :guard?
    end
  end
end
