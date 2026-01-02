require_relative "../test_helper"

module NBA
  class UtilsTest < Minitest::Test
    cover Utils

    def test_current_season_october_to_december
      date = Date.new(2024, 11, 15)
      Date.stub :today, date do
        season = Utils.current_season

        assert_equal 2024, season
      end
    end

    def test_current_season_january_to_june
      date = Date.new(2024, 3, 15)
      Date.stub :today, date do
        season = Utils.current_season

        assert_equal 2023, season
      end
    end

    def test_current_season_june_returns_previous_year
      date = Date.new(2024, 6, 15)
      Date.stub :today, date do
        season = Utils.current_season

        assert_equal 2023, season
      end
    end

    def test_current_season_july_returns_current_year
      date = Date.new(2024, 7, 1)
      Date.stub :today, date do
        season = Utils.current_season

        assert_equal 2024, season
      end
    end

    def test_build_query_creates_query_string
      query = Utils.build_query(season: 2024, team_id: 1)

      assert_equal "season=2024&team_id=1", query
    end

    def test_build_query_omits_nil_values
      query = Utils.build_query(season: 2024, team_id: nil)

      assert_equal "season=2024", query
    end

    def test_format_season_formats_correctly
      assert_equal "2024-25", Utils.format_season(2024)
      assert_equal "2023-24", Utils.format_season(2023)
      assert_equal "1999-00", Utils.format_season(1999)
    end

    def test_extract_id_returns_id_from_object_with_id_method
      player = Player.new(id: 123)

      assert_equal 123, Utils.extract_id(player)
    end

    def test_extract_id_returns_value_for_primitives
      assert_equal 123, Utils.extract_id(123)
      assert_equal "abc", Utils.extract_id("abc")
    end

    def test_parse_integer_parses_string_integers
      assert_equal 42, Utils.parse_integer("42")
      assert_equal 0, Utils.parse_integer("0")
    end

    def test_parse_integer_returns_integer_unchanged
      assert_equal 42, Utils.parse_integer(42)
    end

    def test_parse_integer_returns_nil_for_nil
      assert_nil Utils.parse_integer(nil)
    end

    def test_parse_integer_returns_nil_for_empty_string
      assert_nil Utils.parse_integer("")
      assert_nil Utils.parse_integer("   ")
    end

    def test_parse_integer_returns_nil_for_invalid_strings
      assert_nil Utils.parse_integer("abc")
      assert_nil Utils.parse_integer("N/A")
    end
  end
end
