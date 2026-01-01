require_relative "../test_helper"

module NBA
  class StandingTest < Minitest::Test
    cover Standing

    def test_objects_with_same_team_id_are_equal
      standing0 = Standing.new(team_id: Team::GSW)
      standing1 = Standing.new(team_id: Team::GSW)

      assert_equal standing0, standing1
    end
  end

  class StandingTeamHydrationTest < Minitest::Test
    cover Standing

    def test_team_returns_team_object
      standing = Standing.new(team_id: Team::GSW)

      team = standing.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
      assert_equal "Golden State Warriors", team.full_name
    end

    def test_team_returns_nil_when_team_id_is_nil
      standing = Standing.new(team_id: nil)

      assert_nil standing.team
    end

    def test_team_returns_nil_for_invalid_team_id
      standing = Standing.new(team_id: 999_999)

      assert_nil standing.team
    end

    def test_team_finds_correct_team_by_id
      standing = Standing.new(team_id: Team::LAL)

      team = standing.team

      assert_equal "Los Angeles Lakers", team.full_name
    end
  end
end
