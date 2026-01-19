require_relative "test_helper"

module NBA
  class CLIScheduleFormatTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_schedule_command_with_format_json_outputs_json
      game = ScheduledGame.new(game_date: "2024-01-15T19:30:00", home_team_tricode: "GSW", away_team_tricode: "LAL")
      run_schedule_command_format(%w[schedule Warriors --format json], [game])
      output = stdout_output

      assert_includes output, "game_date"
      assert_includes output, "2024-01-15"
    end

    def test_schedule_command_with_format_csv_outputs_csv
      game = ScheduledGame.new(game_date: "2024-01-15T19:30:00", home_team_tricode: "GSW", away_team_tricode: "LAL")
      run_schedule_command_format(%w[schedule Warriors --format csv], [game])
      output = stdout_output

      assert_includes output, "game_date"
      assert_includes output, "2024-01-15"
    end

    private

    def run_schedule_command_format(args, games)
      with_mock_teams { Schedule.stub(:by_team, Collection.new(games)) { CLI.start(args) } }
    end
  end
end
