require_relative "../test_helper"

module NBA
  class LeagueDashTeamClutchConstantsTest < Minitest::Test
    cover LeagueDashTeamClutch

    def test_league_dash_team_clutch_constant
      assert_equal "LeagueDashTeamClutch", LeagueDashTeamClutch::LEAGUE_DASH_TEAM_CLUTCH
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashTeamClutch::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashTeamClutch::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashTeamClutch::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashTeamClutch::TOTALS
    end

    def test_per_100_constant
      assert_equal "Per100Possessions", LeagueDashTeamClutch::PER_100
    end

    def test_last_5_minutes_constant
      assert_equal "Last 5 Minutes", LeagueDashTeamClutch::LAST_5_MINUTES
    end

    def test_last_4_minutes_constant
      assert_equal "Last 4 Minutes", LeagueDashTeamClutch::LAST_4_MINUTES
    end

    def test_last_3_minutes_constant
      assert_equal "Last 3 Minutes", LeagueDashTeamClutch::LAST_3_MINUTES
    end

    def test_last_2_minutes_constant
      assert_equal "Last 2 Minutes", LeagueDashTeamClutch::LAST_2_MINUTES
    end

    def test_last_1_minute_constant
      assert_equal "Last 1 Minute", LeagueDashTeamClutch::LAST_1_MINUTE
    end

    def test_ahead_or_behind_constant
      assert_equal "Ahead or Behind", LeagueDashTeamClutch::AHEAD_OR_BEHIND
    end

    def test_behind_or_tied_constant
      assert_equal "Behind or Tied", LeagueDashTeamClutch::BEHIND_OR_TIED
    end

    def test_ahead_or_tied_constant
      assert_equal "Ahead or Tied", LeagueDashTeamClutch::AHEAD_OR_TIED
    end
  end
end
