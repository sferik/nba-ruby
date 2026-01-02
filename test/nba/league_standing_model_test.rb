require_relative "../test_helper"

module NBA
  class LeagueStandingModelTest < Minitest::Test
    cover LeagueStanding

    def test_objects_with_same_team_id_and_season_id_are_equal
      standing0 = LeagueStanding.new(team_id: Team::GSW, season_id: "22024")
      standing1 = LeagueStanding.new(team_id: Team::GSW, season_id: "22024")

      assert_equal standing0, standing1
    end

    def test_objects_with_different_season_id_are_not_equal
      standing0 = LeagueStanding.new(team_id: Team::GSW, season_id: "22024")
      standing1 = LeagueStanding.new(team_id: Team::GSW, season_id: "22023")

      refute_equal standing0, standing1
    end

    def test_full_name_returns_combined_name
      standing = LeagueStanding.new(team_city: "Golden State", team_name: "Warriors")

      assert_equal "Golden State Warriors", standing.full_name
    end

    def test_full_name_handles_nil_values
      standing = LeagueStanding.new(team_city: nil, team_name: nil)

      assert_equal "", standing.full_name
    end

    def test_playoffs_returns_true_when_clinched
      standing = LeagueStanding.new(clinched_playoff_birth: 1)

      assert_predicate standing, :playoffs?
    end

    def test_playoffs_returns_false_when_not_clinched
      standing = LeagueStanding.new(clinched_playoff_birth: 0)

      refute_predicate standing, :playoffs?
    end

    def test_playoffs_returns_false_when_clinched_playoff_birth_nil
      standing = LeagueStanding.new(clinched_playoff_birth: nil)

      refute_predicate standing, :playoffs?
    end

    def test_playoffs_returns_false_when_clinched_playoff_birth_greater_than_one
      standing = LeagueStanding.new(clinched_playoff_birth: 2)

      refute_predicate standing, :playoffs?
    end

    def test_team_returns_nil_when_team_id_is_nil
      standing = LeagueStanding.new(team_id: nil)

      assert_nil standing.team
    end

    def test_team_returns_team_object_when_team_id_valid
      standing = LeagueStanding.new(team_id: Team::GSW)

      result = standing.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end
  end
end
