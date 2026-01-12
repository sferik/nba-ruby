require_relative "../../test_helper"

module NBA
  class BoxScoreAdvancedConstantsTest < Minitest::Test
    cover BoxScoreAdvanced

    def test_player_stats_constant
      assert_equal "PlayerStats", BoxScoreAdvanced::PLAYER_STATS
    end

    def test_team_stats_constant
      assert_equal "TeamStats", BoxScoreAdvanced::TEAM_STATS
    end
  end
end
