require_relative "../../test_helper"

module NBA
  class LeaderTest < Minitest::Test
    cover Leader

    def test_objects_with_same_player_id_and_category_are_equal
      leader0 = Leader.new(player_id: 201_939, category: "PTS")
      leader1 = Leader.new(player_id: 201_939, category: "PTS")

      assert_equal leader0, leader1
    end

    def test_objects_with_different_category_are_not_equal
      leader0 = Leader.new(player_id: 201_939, category: "PTS")
      leader1 = Leader.new(player_id: 201_939, category: "AST")

      refute_equal leader0, leader1
    end
  end
end
