require_relative "test_helper"
require_relative "leaders_formatters_test_helper"

module NBA
  class FormatLeaderRowTest < Minitest::Test
    include LeadersFormattersTestHelper

    cover CLI::Formatters::LeadersFormatters

    def test_includes_rank_with_dot
      leader = mock_leader(1, "LeBron James", 30.5)
      widths = {rank: 1, name: 12}

      assert_includes format_leader_row(leader, widths), "1."
    end

    def test_includes_player_name
      leader = mock_leader(1, "LeBron James", 30.5)
      widths = {rank: 1, name: 12}

      assert_includes format_leader_row(leader, widths), "LeBron James"
    end

    def test_includes_value
      leader = mock_leader(1, "LeBron James", 30.5)
      widths = {rank: 1, name: 12}

      assert_includes format_leader_row(leader, widths), "30.5"
    end

    def test_rank_right_justified_to_width
      leader = mock_leader(1, "Test", 25.0)
      widths = {rank: 2, name: 4}
      result = format_leader_row(leader, widths)

      # Rank 1 with width 2 should be " 1"
      assert_match(/\A\s*1\./, result)
    end

    def test_rank_width_respected
      leader = mock_leader(5, "Test", 25.0)
      widths = {rank: 3, name: 4}
      result = format_leader_row(leader, widths)

      # Rank 5 with width 3 should be "  5"
      assert_match(/\A\s{2}5\./, result)
    end

    def test_name_left_justified_to_width
      leader = mock_leader(1, "Curry", 28.0)
      widths = {rank: 1, name: 10}
      result = format_leader_row(leader, widths)

      # "Curry" (5 chars) should be padded to 10 chars
      assert_includes result, "Curry     "
    end

    def test_name_width_exact
      leader = mock_leader(1, "A", 20.0)
      widths = {rank: 1, name: 5}
      result = format_leader_row(leader, widths)

      # "A" with width 5 should be "A    " (4 trailing spaces)
      assert_includes result, "A    "
    end

    def test_rank_converts_to_string
      leader = mock_leader(10, "Test", 25.0)
      widths = {rank: 2, name: 4}

      # This tests that rank.to_s is called (Integer converted to String)
      result = format_leader_row(leader, widths)

      assert_includes result, "10."
    end

    def test_uses_rjust_for_rank
      leader = mock_leader(1, "Test", 25.0)
      widths = {rank: 2, name: 4}
      result = format_leader_row(leader, widths)

      # With rjust(2), rank 1 should be " 1" not "1 "
      assert_match(/\s1\./, result)
      refute_match(/1\s\./, result)
    end

    def test_uses_ljust_for_name
      leader = mock_leader(1, "A", 25.0)
      widths = {rank: 1, name: 3}
      result = format_leader_row(leader, widths)

      # With ljust(3), "A" should be "A  " not "  A"
      assert_includes result, "A  "
      refute_includes result, "  A"
    end

    def test_leader_rank_attribute_accessed
      leader = mock_leader(7, "Test Player", 20.0)
      widths = {rank: 1, name: 11}
      result = format_leader_row(leader, widths)

      assert_includes result, "7."
    end

    def test_leader_player_name_attribute_accessed
      leader = mock_leader(1, "Kevin Durant", 27.5)
      widths = {rank: 1, name: 12}
      result = format_leader_row(leader, widths)

      assert_includes result, "Kevin Durant"
    end

    def test_leader_value_attribute_accessed
      leader = mock_leader(1, "Test", 33.3)
      widths = {rank: 1, name: 4}
      result = format_leader_row(leader, widths)

      assert_includes result, "33.3"
    end

    def test_outputs_value_not_struct_representation
      leader = mock_leader(1, "Test", 25.5)
      widths = {rank: 1, name: 4}
      result = format_leader_row(leader, widths)

      # Ensure we output the value, not the struct representation
      refute_includes result, "#<struct"
    end

    def test_value_appears_at_end_of_row
      leader = mock_leader(1, "Test", 99.9)
      widths = {rank: 1, name: 4}
      result = format_leader_row(leader, widths)

      # Value should be at the end, not wrapped in struct notation
      assert_match(/99\.9\z/, result)
    end
  end
end
