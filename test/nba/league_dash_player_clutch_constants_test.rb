require_relative "../test_helper"

module NBA
  class LeagueDashPlayerClutchConstantsTest < Minitest::Test
    cover LeagueDashPlayerClutch

    def test_league_dash_player_clutch_constant
      assert_equal "LeagueDashPlayerClutch", LeagueDashPlayerClutch::LEAGUE_DASH_PLAYER_CLUTCH
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashPlayerClutch::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashPlayerClutch::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashPlayerClutch::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashPlayerClutch::TOTALS
    end

    def test_per_36_constant
      assert_equal "Per36", LeagueDashPlayerClutch::PER_36
    end

    def test_last_5_minutes_constant
      assert_equal "Last 5 Minutes", LeagueDashPlayerClutch::LAST_5_MINUTES
    end

    def test_last_4_minutes_constant
      assert_equal "Last 4 Minutes", LeagueDashPlayerClutch::LAST_4_MINUTES
    end

    def test_last_3_minutes_constant
      assert_equal "Last 3 Minutes", LeagueDashPlayerClutch::LAST_3_MINUTES
    end

    def test_last_2_minutes_constant
      assert_equal "Last 2 Minutes", LeagueDashPlayerClutch::LAST_2_MINUTES
    end

    def test_last_1_minute_constant
      assert_equal "Last 1 Minute", LeagueDashPlayerClutch::LAST_1_MINUTE
    end

    def test_ahead_or_behind_constant
      assert_equal "Ahead or Behind", LeagueDashPlayerClutch::AHEAD_OR_BEHIND
    end

    def test_behind_or_tied_constant
      assert_equal "Behind or Tied", LeagueDashPlayerClutch::BEHIND_OR_TIED
    end

    def test_ahead_or_tied_constant
      assert_equal "Ahead or Tied", LeagueDashPlayerClutch::AHEAD_OR_TIED
    end
  end
end
