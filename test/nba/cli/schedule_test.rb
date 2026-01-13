require_relative "test_helper"

module NBA
  class CLIScheduleTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_schedule_command_with_valid_team
      game = build_schedule_game("2024-01-15T19:30:00", "GSW", "LAL")
      run_schedule_command(%w[schedule Warriors], [game])

      assert_includes stdout_output, "Schedule for Golden State Warriors"
    end

    def test_schedule_command_with_away_game
      game = build_away_schedule_game("2024-01-15T19:30:00", "LAL")
      run_schedule_command(%w[schedule Warriors], [game])

      assert_includes stdout_output, "@ LAL"
    end

    def test_schedule_command_with_home_game
      game = build_schedule_game("2024-01-15T19:30:00", "GSW", "LAL")
      run_schedule_command(%w[schedule Warriors], [game])

      assert_includes stdout_output, "vs LAL"
    end

    def test_schedule_command_with_invalid_team
      Teams.stub(:all, Collection.new([])) { CLI.start(%w[schedule InvalidTeam]) }

      assert_includes stdout_output, "No team found"
    end

    def test_schedule_command_shows_all_games
      games = build_schedule_games(25)
      run_schedule_command(%w[schedule Warriors], games)

      assert_equal 25, stdout_output.scan(/^\d{4}-\d{2}-\d{2}:/).size
    end

    def test_schedule_command_with_nil_game_date
      game = build_schedule_game(nil, "GSW", "LAL")
      run_schedule_command(%w[schedule Warriors], [game])

      assert_includes stdout_output, "TBD"
    end

    def test_schedule_command_with_season
      game = build_schedule_game("2024-01-15T19:30:00", "GSW", "LAL")
      season_received = nil
      mock = lambda { |season:, **|
        season_received = season
        Collection.new([game])
      }
      run_schedule_command_with_method(%w[schedule Warriors -s 2023], mock)

      assert_equal 2023, season_received
    end

    def test_schedule_command_finds_team_by_abbreviation
      game = build_schedule_game("2024-01-15T19:30:00", "GSW", "LAL")
      run_schedule_command(%w[schedule GSW], [game])

      assert_includes stdout_output, "Schedule for Golden State Warriors"
    end

    def test_schedule_command_invalid_team_shows_team_name_in_error
      Teams.stub(:all, Collection.new([])) { CLI.start(%w[schedule Lakers]) }

      assert_includes stdout_output, "Lakers"
    end

    def test_schedule_command_without_season_does_not_pass_season
      game = build_schedule_game("2024-01-15T19:30:00", "GSW", "LAL")
      season_keyword_received = false
      mock = lambda { |**kwargs|
        season_keyword_received = kwargs.key?(:season)
        Collection.new([game])
      }
      run_schedule_command_with_method(%w[schedule Warriors], mock)

      refute season_keyword_received, "season keyword should not be passed when -s not provided"
    end

    def test_schedule_command_passes_team_to_by_team
      game = build_schedule_game("2024-01-15T19:30:00", "GSW", "LAL")
      team_received = nil
      mock = lambda { |team:, **|
        team_received = team
        Collection.new([game])
      }
      run_schedule_command_with_method(%w[schedule Warriors], mock)

      assert_equal "Golden State Warriors", team_received.full_name
    end

    def test_schedule_command_passes_team_to_by_team_with_season
      game = build_schedule_game("2024-01-15T19:30:00", "GSW", "LAL")
      team_received = nil
      mock = lambda { |team:, **|
        team_received = team
        Collection.new([game])
      }
      run_schedule_command_with_method(%w[schedule Warriors -s 2023], mock)

      assert_equal "Golden State Warriors", team_received.full_name
    end
  end
end
