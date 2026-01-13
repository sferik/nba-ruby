require_relative "test_helper"

module NBA
  class FilterTeamsTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    def test_returns_all_when_name_nil
      teams = [Team.new(full_name: "A"), Team.new(full_name: "B")]

      Teams.stub(:all, Collection.new(teams)) do
        assert_equal 2, filter_teams(nil).size
      end
    end

    def test_filters_by_pattern
      lakers = Team.new(full_name: "Los Angeles Lakers", abbreviation: "LAL")
      clippers = Team.new(full_name: "Los Angeles Clippers", abbreviation: "LAC")
      warriors = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")

      Teams.stub(:all, Collection.new([lakers, clippers, warriors])) do
        assert_equal 2, filter_teams("Los Angeles").size
      end
    end

    def test_filters_by_abbreviation
      lakers = Team.new(full_name: "Los Angeles Lakers", abbreviation: "LAL")
      warriors = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")
      Teams.stub(:all, Collection.new([lakers, warriors])) do
        result = filter_teams("LAL")

        assert_equal 1, result.size
        assert_equal lakers, result.first
      end
    end

    def test_filter_is_case_insensitive
      lakers = Team.new(full_name: "Los Angeles Lakers", abbreviation: "LAL")
      warriors = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")

      Teams.stub(:all, Collection.new([lakers, warriors])) do
        result = filter_teams("lakers")

        assert_equal 1, result.size
        assert_equal lakers, result.first
      end
    end
  end
end
