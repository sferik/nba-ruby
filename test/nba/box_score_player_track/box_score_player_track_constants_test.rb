require_relative "../../test_helper"

module NBA
  class BoxScorePlayerTrackConstantsTest < Minitest::Test
    cover BoxScorePlayerTrack

    def test_player_stats_constant
      assert_equal "PlayerStats", BoxScorePlayerTrack::PLAYER_STATS
    end

    def test_team_stats_constant
      assert_equal "TeamStats", BoxScorePlayerTrack::TEAM_STATS
    end
  end
end
