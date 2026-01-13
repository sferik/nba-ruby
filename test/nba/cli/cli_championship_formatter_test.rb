require_relative "test_helper"

module NBA
  class CLIChampionshipFormatterTest < Minitest::Test
    include CLI::Formatters::TeamFormatters

    cover CLI::Formatters::TeamFormatters

    def test_championship_year_returns_true_for_champion
      stat = Struct.new(:nba_finals_appearance).new("LEAGUE CHAMPION")

      assert championship_year?(stat)
    end

    def test_championship_year_returns_false_for_finals_appearance
      stat = Struct.new(:nba_finals_appearance).new("FINALS APPEARANCE")

      refute championship_year?(stat)
    end

    def test_championship_year_returns_false_for_nil
      stat = Struct.new(:nba_finals_appearance).new(nil)

      refute championship_year?(stat)
    end

    def test_championship_year_returns_false_for_n_a
      stat = Struct.new(:nba_finals_appearance).new("N/A")

      refute championship_year?(stat)
    end
  end
end
