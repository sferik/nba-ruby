require_relative "test_helper"

module NBA
  class CLIStandingsTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_standings_command
      standing = build_standing(team_name: "Golden State Warriors", wins: 53, losses: 29)
      stub_standings([standing]) { CLI.start(["standings"]) }
      output = stdout_output

      assert_includes output, "Golden State Warriors"
      assert_includes output, "53-29"
    end

    def test_standings_command_with_conference
      standing = build_standing(team_name: "Phoenix Suns", wins: 64, losses: 18)
      Standings.stub(:conference, Collection.new([standing])) do
        CLI.start(["standings", "-c", "West"])
      end

      assert_includes stdout_output, "Phoenix Suns"
    end

    def test_standings_command_with_season
      standing = build_standing(team_name: "Milwaukee Bucks", wins: 51, losses: 31)
      season_received = nil
      mock_method = lambda { |season:|
        season_received = season
        Collection.new([standing])
      }
      Standings.stub(:all, mock_method) { CLI.start(["standings", "-s", "2022"]) }

      assert_equal 2022, season_received
    end

    def test_standings_command_with_conference_and_season
      standing = build_standing(team_name: "Phoenix Suns", wins: 64, losses: 18)
      season_received = nil
      mock_method = lambda { |_conf, season: nil|
        season_received = season
        Collection.new([standing])
      }
      Standings.stub(:conference, mock_method) { CLI.start(["standings", "-c", "West", "-s", "2022"]) }

      assert_equal 2022, season_received
    end

    def test_standings_command_without_season_does_not_pass_season
      standing = build_standing(team_name: "Test Team", wins: 50, losses: 32)
      season_keyword_received = false
      mock = lambda { |**kwargs|
        season_keyword_received = kwargs.key?(:season)
        Collection.new([standing])
      }
      Standings.stub(:all, mock) { CLI.start(["standings"]) }

      refute season_keyword_received, "season keyword should not be passed when -s not provided"
    end

    private

    def stub_standings(standings, &)
      Standings.stub(:all, Collection.new(standings), &)
    end

    def build_standing(team_name:, wins:, losses:)
      Struct.new(:team_name, :wins, :losses).new(team_name, wins, losses)
    end
  end
end
