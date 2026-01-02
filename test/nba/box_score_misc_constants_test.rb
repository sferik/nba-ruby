require_relative "../test_helper"

module NBA
  class BoxScoreMiscConstantsTest < Minitest::Test
    cover BoxScoreMisc

    def test_player_stats_constant
      assert_equal "PlayerStats", BoxScoreMisc::PLAYER_STATS
    end

    def test_team_stats_constant
      assert_equal "TeamStats", BoxScoreMisc::TEAM_STATS
    end
  end
end
