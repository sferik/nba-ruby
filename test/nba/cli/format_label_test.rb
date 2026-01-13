require_relative "test_helper"

module NBA
  class FormatLabelTest < Minitest::Test
    include CLI::Formatters

    cover CLI::Formatters

    def test_formats_label_with_value
      assert_equal "Name: John", format_label("Name", "John")
    end

    def test_includes_colon_separator
      result = format_label("Key", "Value")

      assert_includes result, ": "
    end

    def test_label_comes_first
      result = format_label("Label", "Value")

      assert result.start_with?("Label")
    end

    def test_value_comes_after_colon
      result = format_label("Key", "Data")

      assert result.end_with?("Data")
    end

    def test_interpolates_label
      assert_equal "Team: Warriors", format_label("Team", "Warriors")
    end

    def test_interpolates_value
      assert_equal "Score: 100", format_label("Score", "100")
    end
  end
end
