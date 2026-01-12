require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerBioStatsConstantsTest < Minitest::Test
    cover LeagueDashPlayerBioStats

    def test_league_dash_player_bio_stats_constant
      assert_equal "LeagueDashPlayerBioStats", LeagueDashPlayerBioStats::LEAGUE_DASH_PLAYER_BIO_STATS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashPlayerBioStats::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashPlayerBioStats::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashPlayerBioStats::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashPlayerBioStats::TOTALS
    end
  end
end
