require_relative "test_helper"

module NBA
  class CLIGamesTimeConversionTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_games_command_converts_et_time_to_local
      game = build_game(home_team: gsw, away_team: lal, status: "7:30 pm ET")
      stub_scoreboard([game]) { CLI.start(["games"]) }
      output = stdout_output

      # Should show local timezone abbreviation, not ET
      refute_includes output, " ET"
      assert_match(/\d{1,2}:\d{2} [AP]M \w+/, output)
    end

    def test_games_command_preserves_non_time_status
      game = build_game(home_team: gsw, away_team: lal, status: "Final", home_score: 100, away_score: 90)
      stub_scoreboard([game]) { CLI.start(["games"]) }

      assert_includes stdout_output, "Final"
    end

    def test_games_command_handles_nil_status
      game = build_game(home_team: gsw, away_team: lal, status: nil)
      stub_scoreboard([game]) { CLI.start(["games"]) }

      assert_includes stdout_output, "TBD"
    end

    def test_games_command_converts_am_time
      game = build_game(home_team: gsw, away_team: lal, status: "11:30 am ET")
      stub_scoreboard([game]) { CLI.start(["games"]) }
      output = stdout_output

      refute_includes output, " ET"
      assert_match(/\d{1,2}:\d{2} [AP]M \w+/, output)
    end

    def test_games_command_converts_12_pm_correctly
      game = build_game(home_team: gsw, away_team: lal, status: "12:00 pm ET")
      stub_scoreboard([game]) { CLI.start(["games"]) }
      output = stdout_output

      refute_includes output, " ET"
      assert_match(/\d{1,2}:\d{2} [AP]M \w+/, output)
    end

    def test_games_command_converts_12_am_correctly
      game = build_game(home_team: gsw, away_team: lal, status: "12:00 am ET")
      stub_scoreboard([game]) { CLI.start(["games"]) }
      output = stdout_output

      refute_includes output, " ET"
      assert_match(/\d{1,2}:\d{2} [AP]M \w+/, output)
    end
  end
end
