require_relative "test_helper"

module NBA
  class CLILeadersFormatTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_leaders_command_with_format_json_outputs_json
      leader = Leader.new(rank: 1, player_name: "Stephen Curry", value: 32.4)
      stub_leaders([leader]) { CLI.start(["leaders", "--format", "json"]) }
      output = stdout_output

      assert_includes output, "player_name"
      assert_includes output, "Stephen Curry"
    end

    def test_leaders_command_with_format_csv_outputs_csv
      leader = Leader.new(rank: 1, player_name: "Stephen Curry", value: 32.4)
      stub_leaders([leader]) { CLI.start(["leaders", "--format", "csv"]) }
      output = stdout_output

      assert_includes output, "player_name"
      assert_includes output, "Stephen Curry"
    end

    private

    def stub_leaders(leaders, &)
      Leaders.stub(:find, Collection.new(leaders), &)
    end
  end
end
