require_relative "test_helper"

module NBA
  class MaxLengthTest < Minitest::Test
    include CLI::Formatters

    cover CLI::Formatters

    def test_returns_max_string_length
      assert_equal 5, max_length(%w[a bb ccc dddd eeeee])
    end

    def test_returns_length_of_longest_string
      assert_equal 3, max_length(%w[a bb ccc])
    end

    def test_converts_values_to_strings
      assert_equal 3, max_length([1, 22, 333])
    end

    def test_maps_each_value
      assert_equal 2, max_length([1, 22])
    end

    def test_calls_to_s_on_values
      obj = Object.new
      def obj.to_s = "hello"

      assert_equal 5, max_length([obj])
    end

    def test_calls_length_on_string
      assert_equal 4, max_length(["test"])
    end

    def test_returns_max_of_all_values
      assert_equal 4, max_length(%w[ab abcd abc])
    end
  end
end
