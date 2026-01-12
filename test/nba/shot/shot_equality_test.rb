require_relative "../../test_helper"

module NBA
  class ShotTest < Minitest::Test
    cover Shot

    def test_objects_with_same_game_id_and_game_event_id_are_equal
      shot0 = Shot.new(game_id: "0022400001", game_event_id: 1)
      shot1 = Shot.new(game_id: "0022400001", game_event_id: 1)

      assert_equal shot0, shot1
    end

    def test_objects_with_different_game_event_id_are_not_equal
      shot0 = Shot.new(game_id: "0022400001", game_event_id: 1)
      shot1 = Shot.new(game_id: "0022400001", game_event_id: 2)

      refute_equal shot0, shot1
    end
  end
end
