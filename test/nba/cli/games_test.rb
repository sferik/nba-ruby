require_relative "test_helper"

module NBA
  class CLIGamesTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_games_command_with_no_games
      stub_scoreboard([]) { CLI.start(["games"]) }

      assert_includes stdout_output, "No games found"
    end

    def test_games_command_with_games
      game = build_final_game
      stub_scoreboard([game]) { CLI.start(["games"]) }
      output = stdout_output

      assert_includes output, "Final"
      assert_includes output, "Warriors"
      assert_includes output, "Lakers"
    end

    def test_games_command_shows_score_for_final_game
      game = build_final_game
      stub_scoreboard([game]) { CLI.start(["games"]) }
      output = stdout_output

      assert_includes output, "118"
      assert_includes output, "109"
    end

    def test_games_command_with_scheduled_game
      game = build_scheduled_test_game
      stub_scoreboard([game]) { CLI.start(["games"]) }
      output = stdout_output

      assert_includes output, "Warriors"
      assert_includes output, "Lakers"
      assert_includes output, "Scheduled"
    end

    def test_games_command_with_in_progress_game
      game = build_in_progress_game
      stub_scoreboard([game]) { CLI.start(["games"]) }
      output = stdout_output

      assert_includes output, "50"
      assert_includes output, "48"
      assert_includes output, "In Progress"
    end

    def test_games_command_with_nil_teams
      game = Game.new(id: "0022400001", status: "Scheduled")
      stub_scoreboard([game]) { CLI.start(["games"]) }

      assert_includes stdout_output, "TBD"
    end

    def test_games_command_extracts_nickname_from_full_name
      team_without_nickname = Team.new(full_name: "Golden State Warriors")
      game = build_game(home_team: team_without_nickname, away_team: lal, status: "Final", home_score: 100, away_score: 90)
      stub_scoreboard([game]) { CLI.start(["games"]) }

      assert_includes stdout_output, "Warriors"
    end

    def test_games_command_with_nil_full_name_returns_tbd
      team_without_name = Team.new(id: 123)
      game = build_game(home_team: team_without_name, away_team: lal, status: "Final", home_score: 100, away_score: 90)
      stub_scoreboard([game]) { CLI.start(["games"]) }

      assert_includes stdout_output, "TBD"
    end

    def test_games_command_aligns_status_column_with_different_lengths
      game1 = build_game(home_team: gsw, away_team: lal, status: "Final", home_score: 100, away_score: 90)
      game2 = build_game(home_team: gsw, away_team: lal, status: "In Progress", home_score: 50, away_score: 48)
      stub_scoreboard([game1, game2]) { CLI.start(["games"]) }

      assert_status_alignment_in_output
    end

    def test_games_command_aligns_team_columns_with_different_lengths
      short_team = Team.new(full_name: "Utah Jazz", nickname: "Jazz")
      long_team = Team.new(full_name: "Golden State Warriors", nickname: "Warriors")
      game1 = build_game(home_team: short_team, away_team: lal, status: "Final", home_score: 100, away_score: 90)
      game2 = build_game(home_team: long_team, away_team: lal, status: "Final", home_score: 110, away_score: 100)
      stub_scoreboard([game1, game2]) { CLI.start(["games"]) }

      output = stdout_output

      assert_includes output, "Jazz"
      assert_includes output, "Warriors"
    end

    def test_games_command_formats_scores_when_present
      game = build_game(home_team: gsw, away_team: lal, status: "Final", home_score: 118, away_score: 109)
      stub_scoreboard([game]) { CLI.start(["games"]) }
      output = stdout_output

      assert_includes output, "118"
      assert_includes output, "109"
      assert_includes output, ":"
    end

    def test_games_command_displays_dash_for_nil_scores
      game = build_game(home_team: gsw, away_team: lal, status: "Scheduled")
      stub_scoreboard([game]) { CLI.start(["games"]) }
      output = stdout_output

      # Scores should be displayed as dashes when nil
      assert_includes output, "-"
    end

    private

    def build_final_game
      build_game(home_team: gsw, away_team: lal, home_score: 118, away_score: 109, status: "Final", arena: "Chase Center")
    end

    def build_scheduled_test_game
      build_game(home_team: gsw, away_team: lal, status: "Scheduled", arena: "Chase Center")
    end

    def build_in_progress_game
      build_game(home_team: gsw, away_team: lal, home_score: 50, away_score: 48, status: "In Progress")
    end

    def assert_status_alignment_in_output
      lines = stdout_output.lines.select { |l| l.include?("Warriors") }

      assert_equal 2, lines.size
      assert(lines.any? { |l| l.include?("Final") })
      assert(lines.any? { |l| l.include?("In Progress") })
    end
  end
end
