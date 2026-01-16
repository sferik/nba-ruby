require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class RjustTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters

    def test_rjust_pads_left_with_spaces
      result = rjust("91", 3)

      assert_equal " 91", result
    end

    def test_rjust_converts_value_to_string
      result = rjust(91, 3)

      assert_equal " 91", result
    end

    def test_rjust_returns_string_when_width_matches
      result = rjust("118", 3)

      assert_equal "118", result
    end

    def test_rjust_returns_original_when_longer_than_width
      result = rjust("1234", 3)

      assert_equal "1234", result
    end

    def test_rjust_pads_multiple_spaces
      result = rjust("9", 3)

      assert_equal "  9", result
    end
  end
end
