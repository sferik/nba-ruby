require_relative "../test_helper"

module NBA
  class PlayerPositionMatchingTest < Minitest::Test
    cover Player

    def test_position_matches_name_when_abbreviation_does_not_match
      player = Player.new(position: Position.new(abbreviation: "X", name: "Guard"))

      assert_predicate player, :guard?
    end

    def test_position_matches_returns_false_when_neither_matches
      player = Player.new(position: Position.new(abbreviation: "X", name: "Unknown"))

      refute_predicate player, :guard?
      refute_predicate player, :forward?
      refute_predicate player, :center?
    end
  end
end
