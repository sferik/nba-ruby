require_relative "dunk_score_leader_hydration_helper"

module NBA
  class DunkScoreLeaderPlayerHydrationTest < Minitest::Test
    include DunkScoreLeaderHydrationHelper

    cover DunkScoreLeader

    def test_player_returns_hydrated_player
      stub_player_info_request
      leader = DunkScoreLeader.new(player_id: 1_631_094)

      player = leader.player

      assert_instance_of Player, player
    end

    def test_player_returns_nil_when_player_id_nil
      leader = DunkScoreLeader.new(player_id: nil)

      assert_nil leader.player
    end
  end
end
