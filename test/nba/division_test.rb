require_relative "../test_helper"

module NBA
  class DivisionTest < Minitest::Test
    cover Division

    def test_objects_with_same_id_are_equal
      division0 = Division.new(id: 0)
      division1 = Division.new(id: 0)

      assert_equal division0, division1
    end
  end
end
