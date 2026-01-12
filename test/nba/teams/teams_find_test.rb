require_relative "../../test_helper"

module NBA
  class TeamsFindTest < Minitest::Test
    cover Teams

    def test_find_returns_team_by_id
      warriors = Teams.find(Team::GSW)

      refute_nil warriors
      assert_instance_of Team, warriors
      assert_equal Team::GSW, warriors.id
    end

    def test_find_returns_team_name_info
      warriors = Teams.find(Team::GSW)

      assert_equal "Golden State Warriors", warriors.full_name
      assert_equal "Warriors", warriors.nickname
      assert_equal "GSW", warriors.abbreviation
    end

    def test_find_returns_team_location_info
      warriors = Teams.find(Team::GSW)

      assert_equal "San Francisco", warriors.city
      assert_equal "California", warriors.state
      assert_equal 1946, warriors.year_founded
    end

    def test_find_returns_team_by_team_object
      team = Team.new(id: Team::GSW)
      warriors = Teams.find(team)

      refute_nil warriors
      assert_instance_of Team, warriors
      assert_equal Team::GSW, warriors.id
    end

    def test_find_returns_nil_for_unknown_id
      assert_nil Teams.find(9_999_999)
    end

    def test_find_does_not_find_team_with_nil_id
      team = Team.new(id: nil)

      assert_nil Teams.find(team)
    end
  end
end
