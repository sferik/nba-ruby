require_relative "test_helper"

module NBA
  class CLIDisplayTeamsTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_teams_with_detailed_false_shows_only_names
      teams = [Team.new(full_name: "A Team"), Team.new(full_name: "B Team")]
      Teams.stub(:all, Collection.new(teams)) { CLI.start(["teams"]) }

      assert_includes stdout_output, "A Team"
      assert_includes stdout_output, "B Team"
    end

    def test_display_teams_with_detailed_true_shows_full_info
      run_teams_command_with_stubs(%w[teams Warriors])

      assert_includes stdout_output, "Golden State Warriors"
      assert_includes stdout_output, "Founded:"
      assert_includes stdout_output, "Conference:"
    end

    def test_display_teams_defaults_to_detailed_true
      team = Team.new(full_name: "Default Test Team", abbreviation: "DTT", year_founded: 2020)
      teams = Collection.new([team])

      stub_team_details(build_team_detail, Collection.new) do
        Teams.stub(:all, teams) { CLI.start(%w[teams Default]) }
      end

      assert_includes stdout_output, "Founded:"
      assert_includes stdout_output, "2020"
    end

    def test_display_teams_outputs_blank_line_between_teams
      run_two_teams_command

      assert_includes stdout_output, "\n\n", "Expected blank line between teams"
    end

    def test_display_teams_skips_blank_line_for_first_team
      team = Team.new(full_name: "Only Team", abbreviation: "ONL", year_founded: 1990)
      teams = Collection.new([team])

      stub_team_details(build_team_detail, Collection.new([])) do
        Teams.stub(:all, teams) { CLI.start(%w[teams Only]) }
      end

      refute_match(/\A\n/, stdout_output)
    end

    def test_display_teams_calls_display_team_roster_when_include_roster_true
      gsw, teams = gsw_team_and_teams
      roster_team = run_roster_command(teams)

      assert_includes stdout_output, build_roster_player.full_name
      assert_equal gsw, roster_team, "Roster.find should be called with the team"
    end

    private

    def run_roster_command(teams)
      roster_team = nil
      roster_mock = lambda { |team:|
        roster_team = team
        Collection.new([build_roster_player])
      }
      stub_team_details(build_team_detail, Collection.new([])) do
        Teams.stub(:all, teams) { Roster.stub(:find, roster_mock) { CLI.start(%w[teams Warriors -r]) } }
      end
      roster_team
    end

    def run_two_teams_command
      team1 = Team.new(full_name: "Alpha Team", abbreviation: "ALP", year_founded: 1990)
      team2 = Team.new(full_name: "Beta Team", abbreviation: "BET", year_founded: 2000)
      teams = Collection.new([team1, team2])

      stub_team_details(build_team_detail, Collection.new([])) do
        Teams.stub(:all, teams) { CLI.start(%w[teams Team]) }
      end
    end
  end
end
