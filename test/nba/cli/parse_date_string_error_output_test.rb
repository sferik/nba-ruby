require_relative "test_helper"

module NBA
  class ParseDateStringErrorOutputTest < Minitest::Test
    include CLITestHelper
    include CLI::Helpers

    cover CLI::Helpers

    def say(message)
      $stdout.puts(message)
    end

    def test_string_outputs_error_message_for_invalid_date
      assert_raises(SystemExit) { parse_date_string("not-a-date") }

      assert_includes stdout_output, "Invalid date"
      assert_includes stdout_output, "not-a-date"
    end
  end
end
