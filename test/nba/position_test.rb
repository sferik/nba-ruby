require_relative "../test_helper"

module NBA
  class PositionTest < Minitest::Test
    cover Position

    def test_objects_with_same_code_are_equal
      position0 = Position.new(code: "PG")
      position1 = Position.new(code: "PG")

      assert_equal position0, position1
    end
  end
end
