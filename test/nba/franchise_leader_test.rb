require_relative "../test_helper"

module NBA
  class FranchiseLeaderTest < Minitest::Test
    cover FranchiseLeader

    def test_objects_with_same_team_id_are_equal
      leader0 = FranchiseLeader.new(team_id: Team::GSW)
      leader1 = FranchiseLeader.new(team_id: Team::GSW)

      assert_equal leader0, leader1
    end

    def test_objects_with_different_team_id_are_not_equal
      leader0 = FranchiseLeader.new(team_id: Team::GSW)
      leader1 = FranchiseLeader.new(team_id: Team::LAL)

      refute_equal leader0, leader1
    end

    def test_team_returns_team_object
      leader = FranchiseLeader.new(team_id: Team::GSW)

      team = leader.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      leader = FranchiseLeader.new(team_id: nil)

      assert_nil leader.team
    end
  end
end
