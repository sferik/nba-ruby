require_relative "../test_helper"

module NBA
  class BoxScoreHustleConstantsTest < Minitest::Test
    cover BoxScoreHustle

    def test_player_stats_constant
      assert_equal "PlayerStats", BoxScoreHustle::PLAYER_STATS
    end

    def test_team_stats_constant
      assert_equal "TeamStats", BoxScoreHustle::TEAM_STATS
    end
  end
end
