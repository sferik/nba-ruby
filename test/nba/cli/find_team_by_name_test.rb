require_relative "test_helper"

module NBA
  class FindTeamByNameTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    def test_finds_by_full_name
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")

      Teams.stub(:all, Collection.new([team])) do
        assert_equal team, find_team_by_name("Warriors")
      end
    end

    def test_finds_by_abbreviation
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")

      Teams.stub(:all, Collection.new([team])) do
        assert_equal team, find_team_by_name("GSW")
      end
    end

    def test_case_insensitive
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")

      Teams.stub(:all, Collection.new([team])) do
        assert_equal team, find_team_by_name("warriors")
      end
    end

    def test_returns_nil_when_not_found
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")

      Teams.stub(:all, Collection.new([team])) do
        assert_nil find_team_by_name("Lakers")
      end
    end
  end
end
