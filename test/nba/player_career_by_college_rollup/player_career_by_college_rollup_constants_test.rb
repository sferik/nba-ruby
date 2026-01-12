require_relative "../../test_helper"

module NBA
  class PlayerCareerByCollegeRollupConstantsTest < Minitest::Test
    cover PlayerCareerByCollegeRollup

    def test_per_game_constant
      assert_equal "PerGame", PlayerCareerByCollegeRollup::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", PlayerCareerByCollegeRollup::TOTALS
    end

    def test_east_constant
      assert_equal "East", PlayerCareerByCollegeRollup::EAST
    end

    def test_midwest_constant
      assert_equal "Midwest", PlayerCareerByCollegeRollup::MIDWEST
    end

    def test_south_constant
      assert_equal "South", PlayerCareerByCollegeRollup::SOUTH
    end

    def test_west_constant
      assert_equal "West", PlayerCareerByCollegeRollup::WEST
    end
  end
end
