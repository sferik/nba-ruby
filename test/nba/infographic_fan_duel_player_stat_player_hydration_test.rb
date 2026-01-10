require_relative "infographic_fan_duel_player_stat_hydration_helper"

module NBA
  class InfographicFanDuelPlayerStatPlayerHydrationTest < Minitest::Test
    include InfographicFanDuelPlayerStatHydrationHelper

    cover InfographicFanDuelPlayerStat

    def test_player_returns_hydrated_player
      stub_player_info_request
      stat = InfographicFanDuelPlayerStat.new(player_id: 201_939)

      player = stat.player

      assert_instance_of Player, player
    end

    def test_player_returns_nil_when_player_id_nil
      stat = InfographicFanDuelPlayerStat.new(player_id: nil)

      assert_nil stat.player
    end
  end
end
