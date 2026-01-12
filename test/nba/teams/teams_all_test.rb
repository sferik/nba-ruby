require_relative "../../test_helper"

module NBA
  class TeamsAllTest < Minitest::Test
    cover Teams

    def test_all_returns_collection_of_all_teams
      teams = Teams.all

      assert_instance_of Collection, teams
      assert_equal 30, teams.size
    end

    def test_all_includes_warriors
      teams = Teams.all
      warriors = teams.find { |t| t.abbreviation.eql?("GSW") }

      refute_nil warriors
      assert_equal Team::GSW, warriors.id
      assert_equal "Golden State Warriors", warriors.full_name
    end
  end
end
