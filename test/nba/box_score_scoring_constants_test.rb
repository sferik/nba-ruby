require_relative "../test_helper"

module NBA
  class BoxScoreScoringConstantsTest < Minitest::Test
    cover BoxScoreScoring

    def test_player_stats_constant
      assert_equal "PlayerStats", BoxScoreScoring::PLAYER_STATS
    end

    def test_team_stats_constant
      assert_equal "TeamStats", BoxScoreScoring::TEAM_STATS
    end
  end
end
