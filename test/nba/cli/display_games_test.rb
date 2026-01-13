require_relative "test_helper"

module NBA
  class CLIDisplayGamesTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_games_outputs_formatted_games
      game = build_final_game
      stub_scoreboard([game]) { CLI.start(["games"]) }

      assert_includes stdout_output, "Warriors"
      assert_includes stdout_output, "Lakers"
    end

    def test_display_games_outputs_each_game
      game1 = build_game(home_team: gsw, away_team: lal, home_score: 100, away_score: 95, status: "Final", arena: "Chase Center")
      game2 = build_game(home_team: lal, away_team: gsw, home_score: 110, away_score: 105, status: "Final", arena: "Staples Center")
      stub_scoreboard([game1, game2]) { CLI.start(["games"]) }

      assert_includes stdout_output, "100"
      assert_includes stdout_output, "110"
    end

    private

    def build_final_game
      build_game(home_team: gsw, away_team: lal, home_score: 118, away_score: 109, status: "Final", arena: "Chase Center")
    end
  end
end
