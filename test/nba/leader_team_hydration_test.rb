require_relative "../test_helper"

module NBA
  class LeaderTeamHydrationTest < Minitest::Test
    cover Leader

    def test_team_returns_team_object
      leader = Leader.new(team_id: Team::GSW)

      team = leader.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
      assert_equal "Golden State Warriors", team.full_name
    end

    def test_team_returns_nil_when_team_id_is_nil
      leader = Leader.new(team_id: nil)

      assert_nil leader.team
    end

    def test_team_returns_nil_for_invalid_team_id
      leader = Leader.new(team_id: 999_999)

      assert_nil leader.team
    end

    def test_team_finds_correct_team_by_id
      leader = Leader.new(team_id: Team::LAL)

      team = leader.team

      assert_equal "Los Angeles Lakers", team.full_name
    end
  end
end
