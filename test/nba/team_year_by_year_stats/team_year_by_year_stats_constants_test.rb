require_relative "../../test_helper"

module NBA
  class TeamYearByYearStatsConstantsTest < Minitest::Test
    cover TeamYearByYearStats

    def test_team_stats_constant
      assert_equal "TeamStats", TeamYearByYearStats::TEAM_STATS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", TeamYearByYearStats::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", TeamYearByYearStats::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", TeamYearByYearStats::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", TeamYearByYearStats::TOTALS
    end
  end
end
