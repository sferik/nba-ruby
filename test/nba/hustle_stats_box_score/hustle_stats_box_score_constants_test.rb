require_relative "../../test_helper"

module NBA
  class HustleStatsBoxScoreConstantsTest < Minitest::Test
    cover HustleStatsBoxScore

    def test_hustle_stats_available_constant
      assert_equal "HustleStatsAvailable", HustleStatsBoxScore::HUSTLE_STATS_AVAILABLE
    end

    def test_player_stats_constant
      assert_equal "PlayerStats", HustleStatsBoxScore::PLAYER_STATS
    end

    def test_team_stats_constant
      assert_equal "TeamStats", HustleStatsBoxScore::TEAM_STATS
    end

    def test_endpoint_constant
      assert_equal "hustlestatsboxscore", HustleStatsBoxScore::ENDPOINT
    end
  end
end
