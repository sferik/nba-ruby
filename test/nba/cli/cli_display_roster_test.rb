require_relative "test_helper"

module NBA
  class CLIDisplayRosterTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_roster_shows_team_header
      _, teams = gsw_team_and_teams
      player = build_test_player
      Teams.stub(:all, teams) do
        Roster.stub(:find, Collection.new([player])) { CLI.start(%w[roster Warriors]) }
      end

      assert_includes stdout_output, "Roster for Golden State Warriors"
    end

    def test_display_roster_outputs_players
      _, teams = gsw_team_and_teams
      player = Player.new(full_name: "Test Player", jersey_number: 1, position: Position.new(abbreviation: "G"), height: "6-0")
      Teams.stub(:all, teams) do
        Roster.stub(:find, Collection.new([player])) { CLI.start(%w[roster Warriors]) }
      end

      assert_includes stdout_output, "Test Player"
    end
  end
end
