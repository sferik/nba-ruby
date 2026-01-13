require_relative "test_helper"

module NBA
  class CLIVersionTest < Minitest::Test
    include CLITestHelper

    cover CLI

    def test_version_command_outputs_version
      CLI.start(["version"])

      assert_includes stdout_output, VERSION.to_s
    end

    def test_version_flag_outputs_version
      CLI.start(["-v"])

      assert_includes stdout_output, VERSION.to_s
    end

    def test_version_long_flag_outputs_version
      CLI.start(["--version"])

      assert_includes stdout_output, VERSION.to_s
    end

    def test_exit_on_failure_returns_true
      assert_predicate CLI, :exit_on_failure?
    end
  end
end
