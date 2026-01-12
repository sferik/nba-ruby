require_relative "../../test_helper"

module NBA
  class LeagueDashPtTeamDefendConstantsTest < Minitest::Test
    cover LeagueDashPtTeamDefend

    def test_league_dash_pt_team_defend_constant
      assert_equal "LeagueDashPtTeamDefend", LeagueDashPtTeamDefend::LEAGUE_DASH_PT_TEAM_DEFEND
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashPtTeamDefend::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashPtTeamDefend::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashPtTeamDefend::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashPtTeamDefend::TOTALS
    end

    def test_overall_constant
      assert_equal "Overall", LeagueDashPtTeamDefend::OVERALL
    end

    def test_three_pointers_constant
      assert_equal "3 Pointers", LeagueDashPtTeamDefend::THREE_POINTERS
    end

    def test_two_pointers_constant
      assert_equal "2 Pointers", LeagueDashPtTeamDefend::TWO_POINTERS
    end

    def test_less_than_6ft_constant
      assert_equal "Less Than 6Ft", LeagueDashPtTeamDefend::LESS_THAN_6FT
    end

    def test_less_than_10ft_constant
      assert_equal "Less Than 10Ft", LeagueDashPtTeamDefend::LESS_THAN_10FT
    end

    def test_greater_than_15ft_constant
      assert_equal "Greater Than 15Ft", LeagueDashPtTeamDefend::GREATER_THAN_15FT
    end
  end
end
