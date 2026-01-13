require_relative "test_helper"

module NBA
  class CLIStandingsConferenceTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_standings_command_with_conference_calls_conference_method
      standing = build_standing(team_name: "Test Team", wins: 50, losses: 32)
      conference_method_called = false
      mock = lambda { |_conf, **|
        conference_method_called = true
        Collection.new([standing])
      }
      Standings.stub(:conference, mock) { CLI.start(["standings", "-c", "East"]) }

      assert conference_method_called, "conference method should be called when -c provided"
    end

    def test_standings_command_passes_conference_value
      standing = build_standing(team_name: "Test Team", wins: 50, losses: 32)
      conference_received = nil
      mock = lambda { |conf, **|
        conference_received = conf
        Collection.new([standing])
      }
      Standings.stub(:conference, mock) { CLI.start(["standings", "-c", "West"]) }

      assert_equal "West", conference_received
    end

    def test_standings_command_normalizes_lowercase_w_to_west
      standing = build_standing(team_name: "Test Team", wins: 50, losses: 32)
      conference_received = nil
      mock = lambda { |conf, **|
        conference_received = conf
        Collection.new([standing])
      }
      Standings.stub(:conference, mock) { CLI.start(["standings", "-c", "w"]) }

      assert_equal "West", conference_received
    end

    def test_standings_command_normalizes_uppercase_w_to_west
      standing = build_standing(team_name: "Test Team", wins: 50, losses: 32)
      conference_received = nil
      mock = lambda { |conf, **|
        conference_received = conf
        Collection.new([standing])
      }
      Standings.stub(:conference, mock) { CLI.start(["standings", "-c", "W"]) }

      assert_equal "West", conference_received
    end

    def test_standings_command_normalizes_lowercase_e_to_east
      standing = build_standing(team_name: "Test Team", wins: 50, losses: 32)
      conference_received = nil
      mock = lambda { |conf, **|
        conference_received = conf
        Collection.new([standing])
      }
      Standings.stub(:conference, mock) { CLI.start(["standings", "-c", "e"]) }

      assert_equal "East", conference_received
    end

    def test_standings_command_normalizes_uppercase_e_to_east
      standing = build_standing(team_name: "Test Team", wins: 50, losses: 32)
      conference_received = nil
      mock = lambda { |conf, **|
        conference_received = conf
        Collection.new([standing])
      }
      Standings.stub(:conference, mock) { CLI.start(["standings", "-c", "E"]) }

      assert_equal "East", conference_received
    end

    private

    def build_standing(team_name:, wins:, losses:)
      Struct.new(:team_name, :wins, :losses).new(team_name, wins, losses)
    end
  end
end
