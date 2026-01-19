require_relative "test_helper"

module NBA
  class CLIGamesFormatTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_games_command_with_format_json_outputs_json
      game = build_final_game
      stub_scoreboard([game]) { CLI.start(["games", "--format", "json"]) }
      output = stdout_output

      assert_includes output, "home_score"
      assert_includes output, "118"
    end

    def test_games_command_with_format_csv_outputs_csv
      game = build_final_game
      stub_scoreboard([game]) { CLI.start(["games", "--format", "csv"]) }
      output = stdout_output

      assert_includes output, "home_score"
      assert_includes output, "118"
    end

    def test_games_command_with_no_games_does_not_output_json
      stub_scoreboard([]) { CLI.start(["games", "--format", "json"]) }
      output = stdout_output

      assert_includes output, "No games found"
      refute_includes output, "[]"
    end

    private

    def gsw = Team.new(full_name: "Golden State Warriors", nickname: "Warriors")

    def lal = Team.new(full_name: "Los Angeles Lakers", nickname: "Lakers")

    def build_final_game
      build_game(home_team: gsw, away_team: lal, home_score: 118, away_score: 109, status: "Final", arena: "Chase Center")
    end
  end
end
