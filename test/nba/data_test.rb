require_relative "../test_helper"

module NBA
  class DataTest < Minitest::Test
    cover Data

    def test_teams_contains_30_teams
      assert_equal 30, Data::TEAMS.size
    end

    def test_teams_includes_warriors
      warriors = Data::TEAMS.find { |t| t[:abbreviation].eql?("GSW") }

      assert_equal Team::GSW, warriors[:id]
      assert_equal "Golden State Warriors", warriors[:full_name]
      assert_equal "Warriors", warriors[:nickname]
    end

    def test_all_teams_have_required_fields
      required_keys = %i[id abbreviation name full_name nickname city state year_founded]

      Data::TEAMS.each do |team|
        required_keys.each do |key|
          assert team.key?(key), "Team #{team[:abbreviation]} missing #{key}"
        end
      end
    end
  end
end
