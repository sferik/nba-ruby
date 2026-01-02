require_relative "../test_helper"

module NBA
  class FranchiseTest < Minitest::Test
    cover Franchise

    def test_objects_with_same_team_id_are_equal
      franchise0 = Franchise.new(team_id: Team::GSW)
      franchise1 = Franchise.new(team_id: Team::GSW)

      assert_equal franchise0, franchise1
    end

    def test_objects_with_different_team_id_are_not_equal
      franchise0 = Franchise.new(team_id: Team::GSW)
      franchise1 = Franchise.new(team_id: Team::LAL)

      refute_equal franchise0, franchise1
    end

    def test_team_returns_team_object
      franchise = Franchise.new(team_id: Team::GSW)

      team = franchise.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      franchise = Franchise.new(team_id: nil)

      assert_nil franchise.team
    end
  end
end
