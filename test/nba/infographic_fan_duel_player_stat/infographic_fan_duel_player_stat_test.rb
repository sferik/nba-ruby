require_relative "../../test_helper"

module NBA
  class InfographicFanDuelPlayerStatTest < Minitest::Test
    cover InfographicFanDuelPlayerStat

    def test_includes_equalizer_with_game_id_and_player_id
      stat1 = InfographicFanDuelPlayerStat.new(game_id: "0022400001", player_id: 201_939)
      stat2 = InfographicFanDuelPlayerStat.new(game_id: "0022400001", player_id: 201_939)

      assert_equal stat1, stat2
    end

    def test_not_equal_with_different_game_id
      stat1 = InfographicFanDuelPlayerStat.new(game_id: "0022400001", player_id: 201_939)
      stat2 = InfographicFanDuelPlayerStat.new(game_id: "0022400002", player_id: 201_939)

      refute_equal stat1, stat2
    end

    def test_not_equal_with_different_player_id
      stat1 = InfographicFanDuelPlayerStat.new(game_id: "0022400001", player_id: 201_939)
      stat2 = InfographicFanDuelPlayerStat.new(game_id: "0022400001", player_id: 202_691)

      refute_equal stat1, stat2
    end
  end
end
