require_relative "../test_helper"

module NBA
  class LeagueDashTeamPtShotConstantsTest < Minitest::Test
    cover LeagueDashTeamPtShot

    def test_league_dash_pt_shots_constant
      assert_equal "LeagueDashPTShots", LeagueDashTeamPtShot::LEAGUE_DASH_PT_SHOTS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashTeamPtShot::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashTeamPtShot::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashTeamPtShot::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashTeamPtShot::TOTALS
    end
  end
end
