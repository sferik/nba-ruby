require_relative "test_helper"

module NBA
  class CLIDisplayScheduleTest < Minitest::Test
    include CLITestHelper

    cover CLI::Display

    def test_display_schedule_shows_team_header
      _, teams = gsw_team_and_teams
      game = build_schedule_game("2024-01-15T19:30:00", "GSW", "LAL")
      Teams.stub(:all, teams) do
        Schedule.stub(:by_team, Collection.new([game])) { CLI.start(%w[schedule Warriors]) }
      end

      assert_includes stdout_output, "Schedule for Golden State Warriors"
    end

    def test_display_schedule_outputs_games
      _, teams = gsw_team_and_teams
      games = [build_schedule_game("2024-01-15T19:30:00", "GSW", "LAL")]
      Teams.stub(:all, teams) do
        Schedule.stub(:by_team, Collection.new(games)) { CLI.start(%w[schedule Warriors]) }
      end

      assert_includes stdout_output, "LAL"
    end
  end
end
