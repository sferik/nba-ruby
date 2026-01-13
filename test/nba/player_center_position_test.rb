require_relative "../test_helper"

module NBA
  class PlayerCenterPositionTest < Minitest::Test
    cover Player

    def test_center_with_abbreviation
      player = Player.new(position: Position.new(abbreviation: "C"))

      assert_predicate player, :center?
    end

    def test_center_with_name
      player = Player.new(position: Position.new(name: "Center"))

      assert_predicate player, :center?
    end

    def test_center_is_not_guard_or_forward
      player = Player.new(position: Position.new(abbreviation: "C"))

      refute_predicate player, :guard?
      refute_predicate player, :forward?
    end

    def test_center_returns_false_when_position_is_nil
      player = Player.new(position: nil)

      refute_predicate player, :center?
    end
  end
end
