require_relative "test_helper"

module NBA
  class CLIDisplayStandingsTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_standings_outputs_ranked_list
      standing = Struct.new(:team_name, :wins, :losses).new("Warriors", 50, 20)
      Standings.stub(:all, Collection.new([standing])) { CLI.start(["standings"]) }

      assert_includes stdout_output, "1."
      assert_includes stdout_output, "Warriors"
      assert_includes stdout_output, "50-20"
    end

    def test_display_standings_outputs_each_standing
      standings = [
        Struct.new(:team_name, :wins, :losses).new("Team A", 50, 20),
        Struct.new(:team_name, :wins, :losses).new("Team B", 45, 25),
        Struct.new(:team_name, :wins, :losses).new("Team C", 40, 30)
      ]
      Standings.stub(:all, Collection.new(standings)) { CLI.start(["standings"]) }

      assert_includes stdout_output, "1."
      assert_includes stdout_output, "2."
      assert_includes stdout_output, "3."
    end
  end
end
