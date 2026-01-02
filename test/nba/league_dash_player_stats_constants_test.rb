require_relative "../test_helper"

module NBA
  class LeagueDashPlayerStatsConstantsTest < Minitest::Test
    cover LeagueDashPlayerStats

    def test_league_dash_player_stats_constant
      assert_equal "LeagueDashPlayerStats", LeagueDashPlayerStats::LEAGUE_DASH_PLAYER_STATS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashPlayerStats::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashPlayerStats::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashPlayerStats::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashPlayerStats::TOTALS
    end

    def test_per_36_constant
      assert_equal "Per36", LeagueDashPlayerStats::PER_36
    end
  end
end
