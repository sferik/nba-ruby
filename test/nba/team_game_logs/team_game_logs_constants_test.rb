require_relative "../../test_helper"

module NBA
  class TeamGameLogsConstantsTest < Minitest::Test
    cover TeamGameLogs

    def test_regular_season_constant
      assert_equal "Regular Season", TeamGameLogs::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", TeamGameLogs::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", TeamGameLogs::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", TeamGameLogs::TOTALS
    end

    def test_result_set_name_constant
      assert_equal "TeamGameLogs", TeamGameLogs::RESULT_SET_NAME
    end

    def test_regular_season_constant_is_frozen
      assert_predicate TeamGameLogs::REGULAR_SEASON, :frozen?
    end

    def test_playoffs_constant_is_frozen
      assert_predicate TeamGameLogs::PLAYOFFS, :frozen?
    end

    def test_per_game_constant_is_frozen
      assert_predicate TeamGameLogs::PER_GAME, :frozen?
    end

    def test_totals_constant_is_frozen
      assert_predicate TeamGameLogs::TOTALS, :frozen?
    end

    def test_result_set_name_constant_is_frozen
      assert_predicate TeamGameLogs::RESULT_SET_NAME, :frozen?
    end
  end
end
