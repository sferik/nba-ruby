require_relative "test_helper"
require_relative "standings_formatters_test_helper"

module NBA
  class CalculateStandingsWidthsTest < Minitest::Test
    include StandingsFormattersTestHelper

    cover CLI::Formatters::StandingsFormatters

    def test_returns_hash_with_rank_key
      standings = [mock_standing("A", 1, 0)]

      assert calculate_standings_widths(standings).key?(:rank)
    end

    def test_returns_hash_with_team_key
      standings = [mock_standing("A", 1, 0)]

      assert calculate_standings_widths(standings).key?(:team)
    end

    def test_rank_width_is_length_of_size
      standings = Array.new(9) { |i| mock_standing("Team#{i}", 1, 0) }

      # 9 standings, max rank is 9 (1 digit)
      assert_equal 1, calculate_standings_widths(standings)[:rank]
    end

    def test_rank_width_for_double_digits
      standings = Array.new(30) { |i| mock_standing("Team#{i}", 1, 0) }

      # 30 standings, max rank is 30 (2 digits)
      assert_equal 2, calculate_standings_widths(standings)[:rank]
    end

    def test_rank_width_calls_size_on_collection
      standings = [mock_standing("A", 1, 0), mock_standing("B", 1, 0)]

      # Size is 2, so 2.to_s.length = 1
      assert_equal 1, calculate_standings_widths(standings)[:rank]
    end

    def test_rank_width_calls_to_s_on_size
      standings = Array.new(10) { |i| mock_standing("Team#{i}", 1, 0) }

      # Size is 10, so 10.to_s.length = 2
      assert_equal 2, calculate_standings_widths(standings)[:rank]
    end

    def test_rank_width_calls_length_on_string
      standings = Array.new(100) { |i| mock_standing("Team#{i}", 1, 0) }

      # Size is 100, so 100.to_s.length = 3
      assert_equal 3, calculate_standings_widths(standings)[:rank]
    end

    def test_team_width_uses_max_team_name_length
      standings = [
        mock_standing("Warriors", 50, 20),
        mock_standing("Lakers", 45, 25),
        mock_standing("A", 10, 60)
      ]

      # "Warriors" is longest at 8 chars
      assert_equal 8, calculate_standings_widths(standings)[:team]
    end

    def test_team_width_calls_map_with_team_name
      standings = [mock_standing("Boston Celtics", 60, 10)]

      # "Boston Celtics" is 14 chars
      assert_equal 14, calculate_standings_widths(standings)[:team]
    end

    def test_team_width_uses_max_length_helper
      standings = [
        mock_standing("A", 1, 0),
        mock_standing("ABC", 1, 0),
        mock_standing("AB", 1, 0)
      ]

      # max_length should return 3 for "ABC"
      assert_equal 3, calculate_standings_widths(standings)[:team]
    end
  end
end
