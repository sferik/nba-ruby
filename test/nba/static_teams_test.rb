require_relative "../test_helper"

module NBA
  class StaticTeamsTest < Minitest::Test
    cover Static

    def test_teams_returns_all_teams
      teams = Static.teams

      assert_equal 30, teams.size
    end

    def test_find_team_by_id_returns_matching_team
      team = Static.find_team_by_id(Team::GSW)

      assert_equal "Golden State Warriors", team[:full_name]
    end

    def test_find_team_by_id_returns_nil_for_unknown_id
      team = Static.find_team_by_id(999_999)

      assert_nil team
    end

    def test_find_team_by_abbreviation_returns_matching_team
      team = Static.find_team_by_abbreviation("GSW")

      assert_equal Team::GSW, team[:id]
    end

    def test_find_team_by_abbreviation_is_case_insensitive
      team = Static.find_team_by_abbreviation("gsw")

      assert_equal Team::GSW, team[:id]
    end

    def test_find_team_by_abbreviation_returns_nil_for_unknown
      team = Static.find_team_by_abbreviation("XXX")

      assert_nil team
    end

    def test_find_teams_by_city_returns_matching_teams
      teams = Static.find_teams_by_city("Los Angeles")

      assert_equal 2, teams.size
    end

    def test_find_teams_by_city_includes_lakers
      teams = Static.find_teams_by_city("Los Angeles")
      abbreviations = teams.map { |t| t[:abbreviation] }

      assert_includes abbreviations, "LAL"
    end

    def test_find_teams_by_city_includes_clippers
      teams = Static.find_teams_by_city("Los Angeles")
      abbreviations = teams.map { |t| t[:abbreviation] }

      assert_includes abbreviations, "LAC"
    end

    def test_find_teams_by_city_is_case_insensitive
      teams = Static.find_teams_by_city("los angeles")

      assert_equal 2, teams.size
    end

    def test_find_teams_by_city_returns_empty_for_no_match
      teams = Static.find_teams_by_city("Nonexistent City")

      assert_empty teams
    end

    def test_find_teams_by_state_returns_matching_teams
      teams = Static.find_teams_by_state("California")

      assert_equal 4, teams.size
    end

    def test_find_teams_by_state_is_case_insensitive
      teams = Static.find_teams_by_state("california")

      assert_equal 4, teams.size
    end

    def test_find_teams_by_state_returns_empty_for_no_match
      teams = Static.find_teams_by_state("Nonexistent State")

      assert_empty teams
    end

    def test_find_team_by_nickname_returns_matching_team
      team = Static.find_team_by_nickname("Warriors")

      assert_equal Team::GSW, team[:id]
    end

    def test_find_team_by_nickname_is_case_insensitive
      team = Static.find_team_by_nickname("warriors")

      assert_equal Team::GSW, team[:id]
    end

    def test_find_team_by_nickname_returns_nil_for_no_match
      team = Static.find_team_by_nickname("Nonexistent")

      assert_nil team
    end
  end
end
