require_relative "test_helper"

module NBA
  class CLILeadersCategoryTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_leaders_command_default_category
      leader = build_leader(rank: 1, player_name: "Joel Embiid", value: 33.1)
      stub_leaders([leader]) { CLI.start(["leaders"]) }
      output = stdout_output

      assert_includes output, "League Leaders - PTS"
      assert_includes output, "Joel Embiid"
      assert_includes output, "33.1"
    end

    def test_leaders_command_displays_category_in_uppercase
      leader = build_leader(rank: 1, player_name: "Test", value: 10.0)
      stub_leaders([leader]) { CLI.start(%w[leaders reb]) }
      output = stdout_output

      # Category should be displayed in uppercase even if provided lowercase
      assert_includes output, "League Leaders - REB"
    end

    def test_leaders_command_with_reb_category
      assert_category_resolves_to("REB", Leaders::REB)
    end

    def test_leaders_command_with_ast_category
      assert_category_resolves_to("AST", Leaders::AST)
    end

    def test_leaders_command_with_stl_category
      assert_category_resolves_to("STL", Leaders::STL)
    end

    def test_leaders_command_with_blk_category
      assert_category_resolves_to("BLK", Leaders::BLK)
    end

    def test_leaders_command_with_fg_pct_category
      assert_category_resolves_to("FG_PCT", Leaders::FG_PCT)
    end

    def test_leaders_command_with_fg3_pct_category
      assert_category_resolves_to("FG3_PCT", Leaders::FG3_PCT)
    end

    def test_leaders_command_with_ft_pct_category
      assert_category_resolves_to("FT_PCT", Leaders::FT_PCT)
    end

    def test_leaders_command_with_unknown_category_defaults_to_pts
      assert_category_resolves_to("UNKNOWN", Leaders::PTS)
    end

    def test_leaders_command_with_points_full_name
      assert_category_resolves_to("points", Leaders::PTS)
    end

    def test_leaders_command_with_rebounds_full_name
      assert_category_resolves_to("rebounds", Leaders::REB)
    end

    def test_leaders_command_with_assists_full_name
      assert_category_resolves_to("assists", Leaders::AST)
    end

    def test_leaders_command_with_steals_full_name
      assert_category_resolves_to("steals", Leaders::STL)
    end

    def test_leaders_command_with_blocks_full_name
      assert_category_resolves_to("blocks", Leaders::BLK)
    end

    def test_leaders_command_passes_category_with_season
      leader = build_leader(rank: 1, player_name: "Test", value: 1.0)
      category_received = nil
      mock = lambda { |category:, **|
        category_received = category
        Collection.new([leader])
      }
      Leaders.stub(:find, mock) { CLI.start(["leaders", "REB", "-s", "2023"]) }

      assert_equal Leaders::REB, category_received
    end

    def test_leaders_command_passes_category_without_season
      leader = build_leader(rank: 1, player_name: "Test", value: 1.0)
      category_received = nil
      mock = lambda { |category:, **|
        category_received = category
        Collection.new([leader])
      }
      Leaders.stub(:find, mock) { CLI.start(%w[leaders AST]) }

      assert_equal Leaders::AST, category_received
    end

    private

    def stub_leaders(leaders, &)
      Leaders.stub(:find, Collection.new(leaders), &)
    end

    def build_leader(rank:, player_name:, value:)
      Struct.new(:rank, :player_name, :value).new(rank, player_name, value)
    end

    def assert_category_resolves_to(input_category, expected_constant)
      leader = build_leader(rank: 1, player_name: "Test Player", value: 10.0)
      category_received = nil
      mock = lambda { |category:, **|
        category_received = category
        Collection.new([leader])
      }
      Leaders.stub(:find, mock) { CLI.start(["leaders", input_category]) }

      assert_equal expected_constant, category_received
    end
  end
end
