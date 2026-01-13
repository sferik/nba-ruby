require_relative "test_helper"

module NBA
  class FormatMultilineLabelTest < Minitest::Test
    include CLI::Formatters

    cover CLI::Formatters

    def test_formats_items_in_pairs
      result = format_multiline_label("Teams", %w[A B C D])

      assert_includes result, "A, B"
      assert_includes result, "C, D"
    end

    def test_first_line_includes_label
      result = format_multiline_label("Items", %w[X Y])

      assert result.start_with?("Items: ")
    end

    def test_continuation_lines_are_indented
      result = format_multiline_label("AB", %w[1 2 3 4])
      lines = result.split("\n")
      # Indent should be label.length + 2 (for ": ")
      # "AB" has length 2, so indent is 4 spaces
      assert lines[1].start_with?("    ")
    end

    def test_indent_length_matches_label_plus_colon_space
      result = format_multiline_label("Test", %w[a b c d])
      lines = result.split("\n")
      # "Test" = 4 chars, ": " = 2 chars, total indent = 6
      # Verify exact indent: 6 spaces followed by content, not 7
      assert_equal "      c, d", lines[1]
    end

    def test_joins_pairs_with_comma
      result = format_multiline_label("X", %w[one two])

      assert_includes result, "one, two"
    end

    def test_joins_lines_with_newline
      result = format_multiline_label("K", %w[a b c d])

      assert_includes result, "\n"
    end

    def test_first_line_contains_first_pair
      result = format_multiline_label("Key", %w[first second third fourth])
      first_line = result.split("\n").first

      assert_includes first_line, "first, second"
    end

    def test_continuation_contains_remaining_pairs
      result = format_multiline_label("Key", %w[first second third fourth])
      continuation = result.split("\n").drop(1).join("\n")

      assert_includes continuation, "third, fourth"
    end

    def test_each_slice_creates_pairs
      result = format_multiline_label("L", %w[a b c d e f])
      lines = result.split("\n")
      # Should have 3 lines: "a, b", "c, d", "e, f"
      assert_equal 3, lines.count
    end

    def test_drop_skips_first_line
      result = format_multiline_label("X", %w[1 2 3 4 5 6])
      lines = result.split("\n")
      # First line should be "X: 1, 2"
      # Second should be "   3, 4" (indented)
      refute lines[1].start_with?("1")
    end

    def test_array_concatenation_preserves_first_line
      result = format_multiline_label("Test", %w[a b c d])
      lines = result.split("\n")

      assert lines.first.start_with?("Test:")
    end

    def test_returns_string_result
      result = format_multiline_label("Key", %w[a b])

      assert_kind_of String, result
    end

    def test_odd_number_of_items
      result = format_multiline_label("X", %w[a b c])

      assert_includes result, "a, b"
      assert_includes result, "c"
    end

    def test_single_pair
      result = format_multiline_label("Key", %w[one two])

      assert_equal "Key: one, two", result
    end
  end
end
