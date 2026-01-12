require_relative "../../test_helper"

module NBA
  class LeagueDashOppPtShotConstantsTest < Minitest::Test
    cover LeagueDashOppPtShot

    def test_league_dash_pt_shots_constant
      assert_equal "LeagueDashPTShots", LeagueDashOppPtShot::LEAGUE_DASH_PT_SHOTS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashOppPtShot::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashOppPtShot::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashOppPtShot::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashOppPtShot::TOTALS
    end
  end
end
