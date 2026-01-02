require_relative "../test_helper"

module NBA
  class BoxScoreTraditionalConstantsTest < Minitest::Test
    cover BoxScoreTraditional

    def test_player_stats_constant
      assert_equal "PlayerStats", BoxScoreTraditional::PLAYER_STATS
    end

    def test_team_stats_constant
      assert_equal "TeamStats", BoxScoreTraditional::TEAM_STATS
    end
  end
end
