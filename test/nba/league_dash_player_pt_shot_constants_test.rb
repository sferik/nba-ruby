require_relative "../test_helper"

module NBA
  class LeagueDashPlayerPtShotConstantsTest < Minitest::Test
    cover LeagueDashPlayerPtShot

    def test_league_dash_pt_shots_constant
      assert_equal "LeagueDashPTShots", LeagueDashPlayerPtShot::LEAGUE_DASH_PT_SHOTS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashPlayerPtShot::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashPlayerPtShot::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashPlayerPtShot::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashPlayerPtShot::TOTALS
    end
  end
end
