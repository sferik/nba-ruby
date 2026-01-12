require_relative "../../test_helper"

module NBA
  class GameLogTest < Minitest::Test
    cover GameLog

    def test_objects_with_same_game_id_and_player_id_are_equal
      log0 = GameLog.new(game_id: "0022400001", player_id: 201_939)
      log1 = GameLog.new(game_id: "0022400001", player_id: 201_939)

      assert_equal log0, log1
    end

    def test_objects_with_different_game_id_are_not_equal
      log0 = GameLog.new(game_id: "0022400001", player_id: 201_939)
      log1 = GameLog.new(game_id: "0022400002", player_id: 201_939)

      refute_equal log0, log1
    end

    def test_objects_with_different_player_id_are_not_equal
      log0 = GameLog.new(game_id: "0022400001", player_id: 201_939)
      log1 = GameLog.new(game_id: "0022400001", player_id: 201_940)

      refute_equal log0, log1
    end
  end
end
