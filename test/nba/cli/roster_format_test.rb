require_relative "test_helper"

module NBA
  class CLIRosterFormatTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_roster_command_with_format_json_outputs_json
      player = Player.new(full_name: "Stephen Curry", jersey_number: 30)
      run_roster_command_format(%w[roster Warriors --format json], [player])
      output = stdout_output

      assert_includes output, "full_name"
      assert_includes output, "Stephen Curry"
    end

    def test_roster_command_with_format_csv_outputs_csv
      player = Player.new(full_name: "Stephen Curry", jersey_number: 30)
      run_roster_command_format(%w[roster Warriors --format csv], [player])
      output = stdout_output

      assert_includes output, "full_name"
      assert_includes output, "Stephen Curry"
    end

    private

    def run_roster_command_format(args, players)
      with_mock_teams { Roster.stub(:find, Collection.new(players)) { CLI.start(args) } }
    end
  end
end
