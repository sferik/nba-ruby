require_relative "../../test_helper"

module NBA
  class BoxScoreFourFactorsConstantsTest < Minitest::Test
    cover BoxScoreFourFactors

    def test_player_stats_constant
      assert_equal "PlayerStats", BoxScoreFourFactors::PLAYER_STATS
    end

    def test_team_stats_constant
      assert_equal "TeamStats", BoxScoreFourFactors::TEAM_STATS
    end
  end
end
