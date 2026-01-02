require_relative "../test_helper"

module NBA
  class BoxScoreUsageConstantsTest < Minitest::Test
    cover BoxScoreUsage

    def test_player_stats_constant
      assert_equal "PlayerStats", BoxScoreUsage::PLAYER_STATS
    end

    def test_team_stats_constant
      assert_equal "TeamStats", BoxScoreUsage::TEAM_STATS
    end
  end
end
