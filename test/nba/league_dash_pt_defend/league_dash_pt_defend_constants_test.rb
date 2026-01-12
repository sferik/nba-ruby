require_relative "../../test_helper"

module NBA
  class LeagueDashPtDefendConstantsTest < Minitest::Test
    cover LeagueDashPtDefend

    def test_league_dash_pt_defend_constant
      assert_equal "LeagueDashPTDefend", LeagueDashPtDefend::LEAGUE_DASH_PT_DEFEND
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashPtDefend::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashPtDefend::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashPtDefend::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashPtDefend::TOTALS
    end

    def test_overall_constant
      assert_equal "Overall", LeagueDashPtDefend::OVERALL
    end

    def test_three_pointers_constant
      assert_equal "3 Pointers", LeagueDashPtDefend::THREE_POINTERS
    end

    def test_two_pointers_constant
      assert_equal "2 Pointers", LeagueDashPtDefend::TWO_POINTERS
    end

    def test_less_than_6ft_constant
      assert_equal "Less Than 6Ft", LeagueDashPtDefend::LESS_THAN_6FT
    end

    def test_less_than_10ft_constant
      assert_equal "Less Than 10Ft", LeagueDashPtDefend::LESS_THAN_10FT
    end

    def test_greater_than_15ft_constant
      assert_equal "Greater Than 15Ft", LeagueDashPtDefend::GREATER_THAN_15FT
    end
  end
end
