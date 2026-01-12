require_relative "../../test_helper"

module NBA
  class LeagueHustleStatsTeamConstantsTest < Minitest::Test
    cover LeagueHustleStatsTeam

    def test_hustle_stats_team_constant
      assert_equal "HustleStatsTeam", LeagueHustleStatsTeam::HUSTLE_STATS_TEAM
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueHustleStatsTeam::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueHustleStatsTeam::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueHustleStatsTeam::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueHustleStatsTeam::TOTALS
    end
  end
end
