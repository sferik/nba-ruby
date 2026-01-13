require_relative "test_helper"

module NBA
  class NormalizeConferenceTest < Minitest::Test
    include CLI::Helpers

    cover CLI::Helpers

    def test_e_returns_east
      assert_equal "East", normalize_conference("E")
    end

    def test_w_returns_west
      assert_equal "West", normalize_conference("W")
    end

    def test_lowercase_e_returns_east
      assert_equal "East", normalize_conference("e")
    end

    def test_east_returns_east
      assert_equal "East", normalize_conference("East")
    end

    def test_west_returns_west
      assert_equal "West", normalize_conference("West")
    end

    def test_unknown_returns_input
      assert_equal "Pacific", normalize_conference("Pacific")
    end

    def test_extracts_first_character_for_lookup
      # "Eastern" starts with "E", which maps to "East"
      # Without [0], "EASTERN" wouldn't be found in the map
      assert_equal "East", normalize_conference("Eastern")
    end

    def test_empty_string_returns_input
      # Empty string [0] returns nil, .to_s converts to "",
      # "" is not found in map, so returns input unchanged
      assert_equal "", normalize_conference("")
    end
  end
end
