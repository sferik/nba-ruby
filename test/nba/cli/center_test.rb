require_relative "test_helper"

module NBA
  class CenterTest < Minitest::Test
    include CLI::Formatters

    cover CLI::Formatters

    def test_centers_value_in_width
      assert_equal "  hi  ", center("hi", 6)
    end

    def test_converts_value_to_string
      assert_equal " 42 ", center(42, 4)
    end

    def test_calls_to_s_on_value
      obj = Object.new
      def obj.to_s = "ab"

      assert_equal " ab ", center(obj, 4)
    end

    def test_uses_width_parameter
      assert_equal "   x   ", center("x", 7)
    end

    def test_returns_string_centered
      result = center("test", 10)

      assert_equal "   test   ", result
    end
  end
end
