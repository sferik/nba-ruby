require_relative "test_helper"

module NBA
  class CLIRosterTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_roster_command_with_season
      season_received = nil
      mock = lambda { |season:, **|
        season_received = season
        Collection.new([build_test_player])
      }
      _, mock_teams = gsw_team_and_teams
      Teams.stub(:all, mock_teams) do
        Roster.stub(:find, mock) { CLI.start(["roster", "Warriors", "-s", "2023"]) }
      end

      assert_equal 2023, season_received
    end

    def test_roster_command_with_valid_team
      mock_roster = Collection.new([build_test_player])
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")
      stub_roster_lookup(team, mock_roster) { CLI.start(%w[roster Warriors]) }

      assert_includes stdout_output, "Roster for Golden State Warriors"
    end

    def test_roster_command_with_invalid_team
      Teams.stub(:all, Collection.new([])) { CLI.start(%w[roster InvalidTeam]) }

      assert_includes stdout_output, "No team found"
    end

    def test_roster_command_with_missing_player_info
      player = Player.new(full_name: "Unknown Player")
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")
      stub_roster_lookup(team, Collection.new([player])) { CLI.start(%w[roster Warriors]) }

      assert_includes stdout_output, "?"
    end

    def test_roster_command_invalid_team_shows_team_name_in_error
      Teams.stub(:all, Collection.new([])) { CLI.start(%w[roster Lakers]) }

      assert_includes stdout_output, "Lakers"
    end

    def test_roster_command_without_season_does_not_pass_season
      season_keyword_received = false
      mock = lambda { |**kwargs|
        season_keyword_received = kwargs.key?(:season)
        Collection.new([build_test_player])
      }
      run_roster_command_with_method(%w[roster Warriors], mock)

      refute season_keyword_received, "season keyword should not be passed when -s not provided"
    end

    def test_roster_command_passes_team_to_find
      team_received = nil
      mock = lambda { |team:, **|
        team_received = team
        Collection.new([build_test_player])
      }
      run_roster_command_with_method(%w[roster Warriors], mock)

      assert_equal "Golden State Warriors", team_received.full_name
    end

    def test_roster_command_passes_team_to_find_with_season
      team_received = nil
      mock = lambda { |team:, **|
        team_received = team
        Collection.new([build_test_player])
      }
      run_roster_command_with_method(%w[roster Warriors -s 2023], mock)

      assert_equal "Golden State Warriors", team_received.full_name
    end

    def test_roster_command_shows_jersey_number
      player = Player.new(full_name: "Stephen Curry", jersey_number: 30, position: Position.new(abbreviation: "G"))
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")
      stub_roster_lookup(team, Collection.new([player])) { CLI.start(%w[roster Warriors]) }

      # Jersey number 30 should appear as "30" (right-justified to 2 chars)
      assert_includes stdout_output, "#30"
    end

    def test_roster_command_shows_position_abbreviation
      player = Player.new(full_name: "Test Player", jersey_number: 5, position: Position.new(abbreviation: "C"))
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")
      stub_roster_lookup(team, Collection.new([player])) { CLI.start(%w[roster Warriors]) }

      assert_includes stdout_output, "C"
    end

    def test_roster_command_shows_player_height
      player = Player.new(full_name: "Test Player", jersey_number: 5, height: "6-7")
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")
      stub_roster_lookup(team, Collection.new([player])) { CLI.start(%w[roster Warriors]) }

      assert_includes stdout_output, "6-7"
    end

    def test_roster_command_shows_single_digit_jersey_padded
      player = Player.new(full_name: "Test Player", jersey_number: 7, position: Position.new(abbreviation: "G"))
      team = Team.new(full_name: "Golden State Warriors", abbreviation: "GSW")
      stub_roster_lookup(team, Collection.new([player])) { CLI.start(%w[roster Warriors]) }

      # Jersey number 7 should appear as " 7" (right-justified to 2 chars)
      assert_includes stdout_output, "# 7"
    end

    private

    def stub_roster_lookup(team, roster, &block)
      Teams.stub(:all, Collection.new([team])) do
        Roster.stub(:find, roster, &block)
      end
    end
  end
end
