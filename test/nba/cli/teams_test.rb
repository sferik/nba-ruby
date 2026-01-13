require_relative "test_helper"

module NBA
  class CLITeamsTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_teams_command_with_matching_name
      run_teams_command_with_stubs(%w[teams Warriors])

      assert_includes stdout_output, "Golden State Warriors"
    end

    def test_teams_command_with_partial_name
      run_teams_command_with_stubs(%w[teams Laker], detail: build_team_detail(abbreviation: "LAL"))

      assert_includes stdout_output, "Los Angeles Lakers"
    end

    def test_teams_command_with_no_match
      stub_team_details { CLI.start(%w[teams NonExistentTeam]) }

      assert_includes stdout_output, "No team found"
      assert_includes stdout_output, "NonExistentTeam"
    rescue ArgumentError
      flunk "teams command raised ArgumentError"
    rescue SystemExit
      flunk "teams command raised SystemExit"
    end

    def test_teams_command_no_match_returns_early
      # Verifies that no match returns early without calling display_teams
      stub_team_details { CLI.start(%w[teams NonExistentTeam]) }

      # Should only show error message, not team details like "Founded:" or "Conference:"
      refute_includes stdout_output, "Founded:"
    rescue ArgumentError
      flunk "teams command raised ArgumentError"
    rescue SystemExit
      flunk "teams command raised SystemExit"
    end

    def test_teams_command_case_insensitive
      run_teams_command_with_stubs(%w[teams warriors])

      assert_includes stdout_output, "Golden State Warriors"
    end

    def test_teams_command_shows_conference_and_division
      team = Team.new(full_name: "Test Team", abbreviation: "LAL", year_founded: 1947)
      run_teams_command_with_stubs(%w[teams Test], teams: Collection.new([team]), detail: build_team_detail(abbreviation: "LAL"))

      assert_includes stdout_output, "Conference: Western Conference"
      assert_includes stdout_output, "Division: Pacific Division"
    end

    def test_teams_command_with_nil_conference_and_division
      team = Team.new(full_name: "Test Team", abbreviation: "TST", city: "Test", year_founded: 2000)
      TeamDetails.stub(:find, ->(_) {}) do
        TeamYearByYearStats.stub(:find, ->(**_) { Collection.new([]) }) do
          Teams.stub(:all, Collection.new([team])) { CLI.start(%w[teams Test]) }
        end
      end

      assert_includes stdout_output, "Conference:"
      assert_includes stdout_output, "Division:"
    end

    def test_teams_command_shows_coach
      run_teams_command_with_stubs(%w[teams Warriors], detail: build_team_detail(head_coach: "Steve Kerr"))

      assert_includes stdout_output, "Coach: Steve Kerr"
    end

    def test_teams_command_without_name_lists_all_teams_alphabetically
      teams = [
        Team.new(full_name: "Los Angeles Lakers", abbreviation: "LAL"),
        Team.new(full_name: "Boston Celtics", abbreviation: "BOS")
      ]

      Teams.stub(:all, Collection.new(teams)) { CLI.start(["teams"]) }
      output = stdout_output

      assert_includes output, "Boston Celtics"
      assert_includes output, "Los Angeles Lakers"
      assert_operator output.index("Boston Celtics"), :<, output.index("Los Angeles Lakers")
    end

    def test_teams_command_matches_abbreviation
      run_teams_command_with_stubs(%w[teams GSW])

      assert_includes stdout_output, "Golden State Warriors"
    end

    def test_teams_command_matches_abbreviation_case_insensitive
      run_teams_command_with_stubs(%w[teams gsw])

      assert_includes stdout_output, "Golden State Warriors"
    end

    def test_teams_command_shows_championships
      stat = build_year_stat(year: "2014-15", nba_finals_appearance: "LEAGUE CHAMPION")
      run_teams_command_with_stubs(%w[teams Warriors], year_stats: Collection.new([stat]))

      assert_includes stdout_output, "Championships: 2014-15"
    end

    def test_teams_command_shows_blank_line_between_multiple_teams
      lakers = Team.new(full_name: "Los Angeles Lakers", abbreviation: "LAL", year_founded: 1947)
      clippers = Team.new(full_name: "Los Angeles Clippers", abbreviation: "LAC", year_founded: 1970)
      run_teams_command_with_stubs(["teams", "Los Angeles"], teams: Collection.new([lakers, clippers]),
        detail: build_team_detail(abbreviation: "LAL"))

      assert_includes stdout_output, "Los Angeles Lakers"
      assert_includes stdout_output, "Los Angeles Clippers"
      assert_includes stdout_output, "\n\n"
    end

    private

    def stub_teams(teams, &) = Teams.stub(:all, Collection.new(teams), &)
  end
end
