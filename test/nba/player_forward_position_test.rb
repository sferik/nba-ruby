require_relative "../test_helper"

module NBA
  class PlayerForwardPositionTest < Minitest::Test
    cover Player

    def test_small_forward_with_abbreviation
      player = Player.new(position: Position.new(abbreviation: "SF"))

      assert_predicate player, :small_forward?
      assert_predicate player, :forward?
    end

    def test_small_forward_with_name
      player = Player.new(position: Position.new(name: "Small Forward"))

      assert_predicate player, :small_forward?
      assert_predicate player, :forward?
    end

    def test_power_forward_with_abbreviation
      player = Player.new(position: Position.new(abbreviation: "PF"))

      assert_predicate player, :power_forward?
      assert_predicate player, :forward?
    end

    def test_power_forward_with_name
      player = Player.new(position: Position.new(name: "Power Forward"))

      assert_predicate player, :power_forward?
      assert_predicate player, :forward?
    end

    def test_forward_with_abbreviation
      player = Player.new(position: Position.new(abbreviation: "F"))

      assert_predicate player, :forward?
      refute_predicate player, :small_forward?
      refute_predicate player, :power_forward?
    end

    def test_forward_with_name
      player = Player.new(position: Position.new(name: "Forward"))

      assert_predicate player, :forward?
      refute_predicate player, :small_forward?
      refute_predicate player, :power_forward?
    end

    def test_forward_is_not_guard_or_center
      player = Player.new(position: Position.new(abbreviation: "F"))

      refute_predicate player, :guard?
      refute_predicate player, :center?
    end

    def test_forward_returns_false_when_position_does_not_match
      player = Player.new(position: Position.new(abbreviation: "G", name: "Guard"))

      refute_predicate player, :small_forward?
      refute_predicate player, :power_forward?
      refute_predicate player, :forward?
    end

    def test_forward_returns_false_when_position_is_nil
      player = Player.new(position: nil)

      refute_predicate player, :small_forward?
      refute_predicate player, :power_forward?
      refute_predicate player, :forward?
    end
  end
end
