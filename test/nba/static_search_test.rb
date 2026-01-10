require_relative "../test_helper"

module NBA
  class StaticSearchTest < Minitest::Test
    cover Static

    def test_find_teams_by_full_name_returns_matching_teams
      teams = Static.find_teams_by_full_name("Warriors")

      assert_equal 1, teams.size
      assert_equal Team::GSW, teams.first[:id]
    end

    def test_find_teams_by_full_name_is_case_insensitive
      teams = Static.find_teams_by_full_name("golden state")

      assert_equal 1, teams.size
    end

    def test_find_teams_by_full_name_supports_partial_match
      teams = Static.find_teams_by_full_name("Los Angeles")

      assert_equal 2, teams.size
    end

    def test_find_teams_by_full_name_returns_empty_for_no_match
      teams = Static.find_teams_by_full_name("Nonexistent")

      assert_empty teams
    end

    def test_find_teams_by_year_founded_returns_matching_teams
      teams = Static.find_teams_by_year_founded(1946)

      assert_operator teams.size, :>=, 3
    end

    def test_find_teams_by_year_founded_returns_teams_with_correct_year
      teams = Static.find_teams_by_year_founded(1946)
      years = teams.map { |t| t[:year_founded] }.uniq

      assert_equal [1946], years
    end

    def test_find_teams_by_year_founded_returns_empty_for_no_match
      teams = Static.find_teams_by_year_founded(1800)

      assert_empty teams
    end

    def test_find_teams_by_city_supports_partial_match
      teams = Static.find_teams_by_city("New")

      assert_operator teams.size, :>=, 2
    end

    def test_teams_returns_team_hashes_with_id
      team = Static.teams.first

      assert_includes team.keys, :id
    end

    def test_teams_returns_team_hashes_with_abbreviation
      team = Static.teams.first

      assert_includes team.keys, :abbreviation
    end

    def test_teams_returns_team_hashes_with_full_name
      team = Static.teams.first

      assert_includes team.keys, :full_name
    end

    def test_teams_returns_team_hashes_with_nickname
      team = Static.teams.first

      assert_includes team.keys, :nickname
    end

    def test_teams_returns_team_hashes_with_city
      team = Static.teams.first

      assert_includes team.keys, :city
    end

    def test_teams_returns_team_hashes_with_state
      team = Static.teams.first

      assert_includes team.keys, :state
    end

    def test_teams_returns_team_hashes_with_year_founded
      team = Static.teams.first

      assert_includes team.keys, :year_founded
    end

    def test_find_teams_by_city_escapes_regex_metacharacters
      teams = Static.find_teams_by_city(".*")

      assert_empty teams
    end

    def test_find_teams_by_state_escapes_regex_metacharacters
      teams = Static.find_teams_by_state(".*")

      assert_empty teams
    end

    def test_find_teams_by_full_name_escapes_regex_metacharacters
      teams = Static.find_teams_by_full_name(".*")

      assert_empty teams
    end
  end
end
