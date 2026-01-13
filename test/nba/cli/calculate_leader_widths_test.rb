require_relative "test_helper"
require_relative "leaders_formatters_test_helper"

module NBA
  class CalculateLeaderWidthsTest < Minitest::Test
    include LeadersFormattersTestHelper

    cover CLI::Formatters::LeadersFormatters

    def test_returns_hash_with_rank_key
      leaders = [mock_leader(1, "A", 20.0)]

      assert calculate_leader_widths(leaders).key?(:rank)
    end

    def test_returns_hash_with_name_key
      leaders = [mock_leader(1, "A", 20.0)]

      assert calculate_leader_widths(leaders).key?(:name)
    end

    def test_rank_width_for_single_digit
      leaders = [mock_leader(5, "A", 20.0)]

      # Rank 5 is 1 digit
      assert_equal 1, calculate_leader_widths(leaders)[:rank]
    end

    def test_rank_width_for_double_digits
      leaders = [mock_leader(1, "A", 30.0), mock_leader(10, "B", 29.0)]

      # Max rank is 10 (2 digits)
      assert_equal 2, calculate_leader_widths(leaders)[:rank]
    end

    def test_rank_width_maps_over_all_leaders
      leaders = [
        mock_leader(1, "A", 30.0),
        mock_leader(2, "B", 29.0),
        mock_leader(100, "C", 28.0)
      ]

      # Rank 100 is longest at 3 digits
      assert_equal 3, calculate_leader_widths(leaders)[:rank]
    end

    def test_rank_width_for_two_digit_rank
      leaders = [mock_leader(10, "Test", 25.0)]

      # Rank 10 has 2 digits
      assert_equal 2, calculate_leader_widths(leaders)[:rank]
    end

    def test_name_width_uses_max_player_name_length
      leaders = [
        mock_leader(1, "LeBron James", 30.0),
        mock_leader(2, "Curry", 28.0),
        mock_leader(3, "A", 27.0)
      ]

      # "LeBron James" is longest at 12 chars
      assert_equal 12, calculate_leader_widths(leaders)[:name]
    end

    def test_name_width_calls_map_with_player_name
      leaders = [mock_leader(1, "Giannis Antetokounmpo", 30.0)]

      # "Giannis Antetokounmpo" is 21 chars
      assert_equal 21, calculate_leader_widths(leaders)[:name]
    end

    def test_name_width_uses_max_length_helper
      leaders = [
        mock_leader(1, "A", 30.0),
        mock_leader(2, "ABC", 29.0),
        mock_leader(3, "AB", 28.0)
      ]

      # max_length should return 3 for "ABC"
      assert_equal 3, calculate_leader_widths(leaders)[:name]
    end

    def test_rank_width_uses_longest_rank
      leaders = [mock_leader(5, "A", 20.0), mock_leader(10, "B", 19.0)]
      widths = calculate_leader_widths(leaders)

      # Rank 10 is longest at 2 digits
      assert_equal 2, widths[:rank]
    end
  end
end
