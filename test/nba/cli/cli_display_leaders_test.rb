require_relative "test_helper"

module NBA
  class CLIDisplayLeadersTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_leaders_shows_category_header
      leader = build_leader(rank: 1, player_name: "Test Player", value: 30.0)
      Leaders.stub(:find, Collection.new([leader])) { CLI.start(%w[leaders pts]) }

      assert_includes stdout_output, "League Leaders"
      assert_includes stdout_output, "PTS"
    end

    def test_display_leaders_outputs_each_leader
      leaders = [
        build_leader(rank: 1, player_name: "Player One", value: 30.0),
        build_leader(rank: 2, player_name: "Player Two", value: 28.5),
        build_leader(rank: 3, player_name: "Player Three", value: 27.0)
      ]
      Leaders.stub(:find, Collection.new(leaders)) { CLI.start(%w[leaders pts]) }

      assert_includes stdout_output, "Player One"
      assert_includes stdout_output, "Player Two"
      assert_includes stdout_output, "Player Three"
    end

    private

    def build_leader(rank:, player_name:, value:)
      Struct.new(:rank, :player_name, :value).new(rank, player_name, value)
    end
  end
end
