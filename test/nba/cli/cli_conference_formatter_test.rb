require_relative "test_helper"

module NBA
  class CLIConferenceFormatterTest < Minitest::Test
    include CLI::Formatters::TeamFormatters

    cover CLI::Formatters::TeamFormatters

    def test_conference_name_eastern_team
      detail = Struct.new(:abbreviation).new("BOS")

      assert_equal "Eastern Conference", conference_name(detail)
    end

    def test_conference_name_western_team
      detail = Struct.new(:abbreviation).new("GSW")

      assert_equal "Western Conference", conference_name(detail)
    end

    def test_conference_name_nil_abbreviation_returns_western
      detail = Struct.new(:abbreviation).new(nil)

      assert_equal "Western Conference", conference_name(detail)
    end

    def test_conference_name_symbol_abbreviation_eastern_team
      # Tests that .to_s is called on abbreviation - symbols need conversion
      detail = Struct.new(:abbreviation).new(:BOS)

      assert_equal "Eastern Conference", conference_name(detail)
    end

    def test_conference_name_symbol_abbreviation_western_team
      detail = Struct.new(:abbreviation).new(:GSW)

      assert_equal "Western Conference", conference_name(detail)
    end

    def test_east_constant_includes_all_eastern_teams
      assert_includes EAST, "BOS"
      assert_includes EAST, "NYK"
      assert_includes EAST, "MIA"
      assert_includes EAST, "CHI"
      assert_includes EAST, "ATL"
    end

    def test_east_constant_excludes_western_teams
      refute_includes EAST, "GSW"
      refute_includes EAST, "LAL"
      refute_includes EAST, "DEN"
    end
  end
end
