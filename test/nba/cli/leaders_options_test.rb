require_relative "test_helper"

module NBA
  class CLILeadersOptionsTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_leaders_command_with_season
      leader = build_leader(rank: 1, player_name: "Joel Embiid", value: 33.1)
      season_received = nil
      mock = lambda { |season:, **|
        season_received = season
        Collection.new([leader])
      }
      Leaders.stub(:find, mock) { CLI.start(["leaders", "-s", "2023"]) }

      assert_equal 2023, season_received
    end

    def test_leaders_command_with_limit
      leader = build_leader(rank: 1, player_name: "James Harden", value: 10.8)
      limit_received = nil
      mock = lambda { |limit:, **|
        limit_received = limit
        Collection.new([leader])
      }
      Leaders.stub(:find, mock) { CLI.start(["leaders", "-l", "5"]) }

      assert_equal 5, limit_received
    end

    def test_leaders_command_without_season_does_not_pass_season
      leader = build_leader(rank: 1, player_name: "Test", value: 1.0)
      season_keyword_received = false
      mock = lambda { |**kwargs|
        season_keyword_received = kwargs.key?(:season)
        Collection.new([leader])
      }
      Leaders.stub(:find, mock) { CLI.start(["leaders"]) }

      refute season_keyword_received, "season keyword should not be passed when -s not provided"
    end

    def test_leaders_command_with_season_passes_season_keyword
      leader = build_leader(rank: 1, player_name: "Test", value: 1.0)
      season_keyword_received = false
      mock = lambda { |**kwargs|
        season_keyword_received = kwargs.key?(:season)
        Collection.new([leader])
      }
      Leaders.stub(:find, mock) { CLI.start(["leaders", "-s", "2023"]) }

      assert season_keyword_received, "season keyword should be passed when -s provided"
    end

    def test_leaders_command_passes_limit_with_season
      leader = build_leader(rank: 1, player_name: "Test", value: 1.0)
      limit_received = nil
      mock = lambda { |limit:, **|
        limit_received = limit
        Collection.new([leader])
      }
      Leaders.stub(:find, mock) { CLI.start(["leaders", "-s", "2023", "-l", "5"]) }

      assert_equal 5, limit_received
    end

    def test_leaders_command_passes_limit_without_season
      leader = build_leader(rank: 1, player_name: "Test", value: 1.0)
      limit_received = nil
      mock = lambda { |limit:, **|
        limit_received = limit
        Collection.new([leader])
      }
      Leaders.stub(:find, mock) { CLI.start(["leaders", "-l", "3"]) }

      assert_equal 3, limit_received
    end

    def test_leaders_command_with_season_value_zero_passes_season
      # In Ruby, 0 is truthy, so -s 0 should trigger the season branch
      leader = build_leader(rank: 1, player_name: "Test", value: 1.0)
      season_received = nil
      mock = lambda { |**kwargs|
        season_received = kwargs[:season] if kwargs.key?(:season)
        Collection.new([leader])
      }
      Leaders.stub(:find, mock) { CLI.start(["leaders", "-s", "0"]) }

      # The season branch SHOULD execute because 0 is truthy in Ruby
      assert_equal 0, season_received
    end

    def test_leaders_with_nil_season_value_does_not_pass_season
      # Kills mutation: options[:season] -> options.key?(:season)
      refute run_leaders_with_falsy_season(nil)
    end

    def test_leaders_with_false_season_value_does_not_pass_season
      refute run_leaders_with_falsy_season(false)
    end

    private

    def run_leaders_with_falsy_season(season_value)
      season_keyword_received = false
      leader = build_leader(rank: 1, player_name: "Test", value: 1.0)
      mock = ->(**kw) { (season_keyword_received = kw.key?(:season)) || Collection.new([leader]) }
      cli = CLI.new
      cli.define_singleton_method(:options) { {limit: 10, season: season_value} }
      Leaders.stub(:find, mock) { cli.leaders }
      season_keyword_received
    end

    def build_leader(rank:, player_name:, value:)
      Struct.new(:rank, :player_name, :value).new(rank, player_name, value)
    end
  end
end
