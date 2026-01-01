require_relative "../test_helper"

module NBA
  class GameTest < Minitest::Test
    cover Game

    def test_objects_with_same_id_are_equal
      game0 = Game.new(id: "0022400001")
      game1 = Game.new(id: "0022400001")

      assert_equal game0, game1
    end
  end
end
