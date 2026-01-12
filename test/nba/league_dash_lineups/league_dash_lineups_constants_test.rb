require_relative "../../test_helper"

module NBA
  class LeagueDashLineupsConstantsTest < Minitest::Test
    cover LeagueDashLineups

    def test_lineups_constant
      assert_equal "Lineups", LeagueDashLineups::LINEUPS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashLineups::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashLineups::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashLineups::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashLineups::TOTALS
    end

    def test_per_100_constant
      assert_equal "Per100Possessions", LeagueDashLineups::PER_100
    end

    def test_five_man_constant
      assert_equal 5, LeagueDashLineups::FIVE_MAN
    end

    def test_four_man_constant
      assert_equal 4, LeagueDashLineups::FOUR_MAN
    end

    def test_three_man_constant
      assert_equal 3, LeagueDashLineups::THREE_MAN
    end

    def test_two_man_constant
      assert_equal 2, LeagueDashLineups::TWO_MAN
    end
  end
end
