require_relative "test_helper"

module NBA
  class CLIHelpTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_help_command_lists_main_commands
      CLI.start(["help"])

      assert_includes stdout_output, "games"
      assert_includes stdout_output, "standings"
    end

    def test_help_command_lists_additional_commands
      CLI.start(["help"])

      assert_includes stdout_output, "teams"
      assert_includes stdout_output, "leaders"
      assert_includes stdout_output, "player"
    end

    def test_help_games_shows_games_help
      CLI.start(%w[help games])
      output = stdout_output

      assert_includes output, "games"
      assert_includes output, "date"
    end

    def test_help_teams_shows_teams_help
      CLI.start(%w[help teams])
      output = stdout_output

      assert_includes output, "teams"
      assert_includes output, "name"
      assert_includes output, "roster"
    end
  end
end
