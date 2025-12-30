require_relative "../test_helper"

module NBA
  class TeamTest < Minitest::Test
    cover Team

    def test_objects_with_same_id_are_equal
      team0 = Team.new(id: 0)
      team1 = Team.new(id: 0)

      assert_equal team0, team1
    end
  end
end
