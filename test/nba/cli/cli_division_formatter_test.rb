require_relative "test_helper"

module NBA
  class CLIDivisionFormatterTest < Minitest::Test
    include CLI::Formatters::TeamFormatters

    cover CLI::Formatters::TeamFormatters

    def test_division_name_atlantic
      detail = Struct.new(:abbreviation).new("BOS")

      assert_equal "Atlantic Division", division_name(detail)
    end

    def test_division_name_pacific
      detail = Struct.new(:abbreviation).new("GSW")

      assert_equal "Pacific Division", division_name(detail)
    end

    def test_division_name_central
      detail = Struct.new(:abbreviation).new("CHI")

      assert_equal "Central Division", division_name(detail)
    end

    def test_division_name_southeast
      detail = Struct.new(:abbreviation).new("MIA")

      assert_equal "Southeast Division", division_name(detail)
    end

    def test_division_name_northwest
      detail = Struct.new(:abbreviation).new("DEN")

      assert_equal "Northwest Division", division_name(detail)
    end

    def test_division_name_southwest
      detail = Struct.new(:abbreviation).new("DAL")

      assert_equal "Southwest Division", division_name(detail)
    end

    def test_division_name_unknown_team_returns_nil
      detail = Struct.new(:abbreviation).new("XXX")

      assert_nil division_name(detail)
    end

    def test_division_name_symbol_abbreviation
      # Tests that .to_s is called on abbreviation - symbols need conversion
      detail = Struct.new(:abbreviation).new(:BOS)

      assert_equal "Atlantic Division", division_name(detail)
    end

    def test_division_name_nil_abbreviation
      detail = Struct.new(:abbreviation).new(nil)

      assert_nil division_name(detail)
    end

    def test_division_for_team_returns_nil_for_unknown
      assert_nil division_for_team("XXX")
    end
  end
end
