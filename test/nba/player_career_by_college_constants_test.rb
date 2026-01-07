require_relative "../test_helper"

module NBA
  class PlayerCareerByCollegeConstantsTest < Minitest::Test
    cover PlayerCareerByCollege

    def test_per_game_constant
      assert_equal "PerGame", PlayerCareerByCollege::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", PlayerCareerByCollege::TOTALS
    end
  end
end
