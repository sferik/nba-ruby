require_relative "test_helper"

module NBA
  class CLIDisplayPlayersListTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_players_list_shows_players_header
      player = build_test_player
      _, teams = gsw_team_and_teams
      stub_team_details(build_team_detail, Collection.new([])) do
        Teams.stub(:all, teams) do
          Roster.stub(:find, Collection.new([player])) { CLI.start(%w[teams Warriors -r]) }
        end
      end

      assert_includes stdout_output, "Players:"
    end

    def test_display_team_roster_skips_when_empty
      _, teams = gsw_team_and_teams
      stub_team_details(build_team_detail, Collection.new([])) do
        Teams.stub(:all, teams) do
          Roster.stub(:find, Collection.new([])) { CLI.start(%w[teams Warriors -r]) }
        end
      end

      refute_includes stdout_output, "Players:"
    end
  end
end
