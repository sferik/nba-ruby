require_relative "../test_helper"

module NBA
  class PlayerCareerStatsConstantsTest < Minitest::Test
    cover PlayerCareerStats

    def test_per_game_constant
      assert_equal "PerGame", PlayerCareerStats::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", PlayerCareerStats::TOTALS
    end
  end
end
