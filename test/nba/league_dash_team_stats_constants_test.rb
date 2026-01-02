require_relative "../test_helper"

module NBA
  class LeagueDashTeamStatsConstantsTest < Minitest::Test
    cover LeagueDashTeamStats

    def test_league_dash_team_stats_constant
      assert_equal "LeagueDashTeamStats", LeagueDashTeamStats::LEAGUE_DASH_TEAM_STATS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashTeamStats::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashTeamStats::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashTeamStats::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashTeamStats::TOTALS
    end

    def test_per_100_constant
      assert_equal "Per100Possessions", LeagueDashTeamStats::PER_100
    end
  end
end
