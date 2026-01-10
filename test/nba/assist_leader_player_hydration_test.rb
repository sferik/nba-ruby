require_relative "assist_leader_hydration_helper"

module NBA
  class AssistLeaderPlayerHydrationTest < Minitest::Test
    include AssistLeaderHydrationHelper

    cover AssistLeader

    def test_player_returns_hydrated_player
      stub_player_info_request
      leader = AssistLeader.new(player_id: 201_566)

      player = leader.player

      assert_instance_of Player, player
    end

    def test_player_returns_nil_when_player_id_nil
      leader = AssistLeader.new(player_id: nil)

      assert_nil leader.player
    end
  end
end
