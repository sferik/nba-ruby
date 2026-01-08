require_relative "../test_helper"

module NBA
  class LeagueDashPtStatsConstantsTest < Minitest::Test
    cover LeagueDashPtStats

    def test_league_dash_pt_stats_constant
      assert_equal "LeagueDashPtStats", LeagueDashPtStats::LEAGUE_DASH_PT_STATS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashPtStats::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashPtStats::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashPtStats::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashPtStats::TOTALS
    end

    def test_player_constant
      assert_equal "Player", LeagueDashPtStats::PLAYER
    end

    def test_team_constant
      assert_equal "Team", LeagueDashPtStats::TEAM
    end

    def test_speed_distance_constant
      assert_equal "SpeedDistance", LeagueDashPtStats::SPEED_DISTANCE
    end
  end
end
