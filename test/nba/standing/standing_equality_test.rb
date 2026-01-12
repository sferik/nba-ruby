require_relative "../../test_helper"

module NBA
  class StandingTest < Minitest::Test
    cover Standing

    def test_objects_with_same_team_id_are_equal
      standing0 = Standing.new(team_id: Team::GSW)
      standing1 = Standing.new(team_id: Team::GSW)

      assert_equal standing0, standing1
    end
  end
end
