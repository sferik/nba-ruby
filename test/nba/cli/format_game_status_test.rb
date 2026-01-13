require_relative "test_helper"
require_relative "game_formatters_test_helper"

module NBA
  class FormatGameStatusTest < Minitest::Test
    include GameFormattersTestHelper

    cover CLI::Formatters::GameFormatters

    def test_returns_tbd_when_nil
      game = Struct.new(:status).new(nil)

      assert_equal "TBD", format_game_status(game)
    end

    def test_returns_converted_time_for_et
      game = Struct.new(:status).new("7:30 pm ET")

      refute_includes format_game_status(game), "ET"
    end

    def test_returns_status_unchanged_for_final
      game = Struct.new(:status).new("Final")

      assert_equal "Final", format_game_status(game)
    end

    def test_strips_whitespace_from_status
      game = Struct.new(:status).new("Halftime            ")

      assert_equal "Halftime", format_game_status(game)
    end
  end
end
