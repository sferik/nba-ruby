require_relative "test_helper"

module NBA
  class CLIStandingsFormatTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_standings_command_with_format_json_outputs_json
      standing = Standing.new(team_name: "Golden State Warriors", wins: 53, losses: 29)
      stub_standings([standing]) { CLI.start(["standings", "--format", "json"]) }
      output = stdout_output

      assert_includes output, "team_name"
      assert_includes output, "Golden State Warriors"
    end

    def test_standings_command_with_format_csv_outputs_csv
      standing = Standing.new(team_name: "Golden State Warriors", wins: 53, losses: 29)
      stub_standings([standing]) { CLI.start(["standings", "--format", "csv"]) }
      output = stdout_output

      assert_includes output, "team_name"
      assert_includes output, "Golden State Warriors"
    end

    private

    def stub_standings(standings, &)
      Standings.stub(:all, Collection.new(standings), &)
    end
  end
end
