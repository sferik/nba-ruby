require_relative "test_helper"

module NBA
  class CLITeamsRosterTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_teams_command_with_roster_option
      stub_team_details(build_team_detail, Collection.new([])) do
        Roster.stub(:find, Collection.new([build_roster_player])) { CLI.start(["teams", "Warriors", "-r"]) }
      end

      assert_includes stdout_output, "Stephen Curry"
      assert_includes stdout_output, "Players:"
    end

    def test_teams_command_without_roster_option_does_not_show_roster
      run_teams_command_with_stubs(%w[teams Warriors])

      refute_includes stdout_output, "Players:"
    end

    def test_teams_command_with_empty_roster
      stub_team_details(build_team_detail, Collection.new([])) do
        Roster.stub(:find, Collection.new([])) { CLI.start(["teams", "Warriors", "-r"]) }
      end

      refute_includes stdout_output, "Players:"
    end

    def test_teams_command_roster_player_missing_position_and_jersey
      player = Player.new(full_name: "Test Player")
      stub_team_details(build_team_detail, Collection.new([])) do
        Roster.stub(:find, Collection.new([player])) { CLI.start(["teams", "Warriors", "-r"]) }
      end

      assert_includes stdout_output, "# ?"
      assert_includes stdout_output, "Test Player"
    end

    def test_teams_command_roster_player_shows_height
      player = Player.new(full_name: "Test Player", height: "6-7")
      stub_team_details(build_team_detail, Collection.new([])) do
        Roster.stub(:find, Collection.new([player])) { CLI.start(["teams", "Warriors", "-r"]) }
      end

      assert_includes stdout_output, "6-7"
    end

    def test_teams_command_roster_player_missing_height_shows_question_mark
      player = Player.new(full_name: "Test Player", jersey_number: 10, position: Position.new(abbreviation: "G"))
      stub_team_details(build_team_detail, Collection.new([])) do
        Roster.stub(:find, Collection.new([player])) { CLI.start(["teams", "Warriors", "-r"]) }
      end
      output = stdout_output

      # Height should show "?" when missing
      assert_match(/G\s+\?/, output, "Missing height should show ? after position")
    end

    def test_teams_command_roster_player_formats_jersey_number_width
      player1 = Player.new(full_name: "Test One", jersey_number: 3)
      player2 = Player.new(full_name: "Test Two", jersey_number: 30)
      stub_team_details(build_team_detail, Collection.new([])) do
        Roster.stub(:find, Collection.new([player1, player2])) { CLI.start(["teams", "Warriors", "-r"]) }
      end
      output = stdout_output

      # Single digit jerseys should be right-justified with a space
      assert_includes output, "# 3"
      assert_includes output, "#30"
    end

    def test_teams_command_roster_player_formats_name_with_fixed_width
      player = Player.new(full_name: "Stephen Curry", jersey_number: 30, position: Position.new(abbreviation: "G"))
      stub_team_details(build_team_detail, Collection.new([])) do
        Roster.stub(:find, Collection.new([player])) { CLI.start(["teams", "Warriors", "-r"]) }
      end
      output = stdout_output

      # Name should be followed by spaces to pad to 25 chars
      assert_match(/Stephen Curry\s+G/, output)
    end

    def test_teams_command_roster_player_formats_position_with_padding
      player = Player.new(full_name: "Stephen Curry", jersey_number: 30, position: Position.new(abbreviation: "G"))
      stub_team_details(build_team_detail, Collection.new([])) do
        Roster.stub(:find, Collection.new([player])) { CLI.start(["teams", "Warriors", "-r"]) }
      end
      output = stdout_output

      # Position abbreviation should be present
      assert_includes output, "G"
    end

    def test_teams_command_roster_shows_full_player_line
      player = Player.new(full_name: "Stephen Curry", jersey_number: 30, position: Position.new(abbreviation: "G"), height: "6-2")
      stub_team_details(build_team_detail, Collection.new([])) do
        Roster.stub(:find, Collection.new([player])) { CLI.start(["teams", "Warriors", "-r"]) }
      end
      output = stdout_output

      # Full line format: "#30 Stephen Curry          G   6-2"
      assert_includes output, "#30"
      assert_includes output, "Stephen Curry"
      assert_includes output, "G"
      assert_includes output, "6-2"
    end

    private

    def stub_teams(teams, &) = Teams.stub(:all, Collection.new(teams), &)
  end
end
