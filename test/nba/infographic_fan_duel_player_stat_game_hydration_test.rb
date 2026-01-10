require_relative "infographic_fan_duel_player_stat_hydration_helper"

module NBA
  class InfographicFanDuelPlayerStatGameHydrationTest < Minitest::Test
    include InfographicFanDuelPlayerStatHydrationHelper

    cover InfographicFanDuelPlayerStat

    def test_game_returns_hydrated_game_object
      stub_box_score_summary_request("0022400001")
      stat = InfographicFanDuelPlayerStat.new(game_id: "0022400001")

      game = stat.game

      assert_instance_of Game, game
      assert_equal "0022400001", game.id
    end

    def test_game_returns_nil_when_game_id_is_nil
      stat = InfographicFanDuelPlayerStat.new(game_id: nil)

      assert_nil stat.game
    end
  end
end
