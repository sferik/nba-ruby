require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class GreenHelperTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters

    def test_green_wraps_text_in_ansi_codes
      result = green("test")

      assert_equal "\e[32mtest\e[0m", result
    end

    def test_green_starts_with_green_code
      result = green("hello")

      assert result.start_with?("\e[32m")
    end

    def test_green_ends_with_reset_code
      result = green("hello")

      assert result.end_with?("\e[0m")
    end

    def test_green_contains_original_text
      result = green("Warriors 118")

      assert_includes result, "Warriors 118"
    end

    def test_green_uses_green_constant
      result = green("text")

      assert_includes result, CLI::Formatters::GREEN
    end

    def test_green_uses_reset_constant
      result = green("text")

      assert_includes result, CLI::Formatters::RESET
    end
  end
end
