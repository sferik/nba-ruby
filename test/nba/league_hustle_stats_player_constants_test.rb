require_relative "../test_helper"

module NBA
  class LeagueHustleStatsPlayerConstantsTest < Minitest::Test
    cover LeagueHustleStatsPlayer

    def test_hustle_stats_player_constant
      assert_equal "HustleStatsPlayer", LeagueHustleStatsPlayer::HUSTLE_STATS_PLAYER
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueHustleStatsPlayer::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueHustleStatsPlayer::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueHustleStatsPlayer::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueHustleStatsPlayer::TOTALS
    end
  end
end
