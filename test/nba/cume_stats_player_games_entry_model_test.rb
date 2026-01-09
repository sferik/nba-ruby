require_relative "../test_helper"

module NBA
  class CumeStatsPlayerGamesEntryModelTest < Minitest::Test
    cover CumeStatsPlayerGamesEntry

    def test_objects_with_same_game_id_are_equal
      entry0 = CumeStatsPlayerGamesEntry.new(game_id: "0022400001")
      entry1 = CumeStatsPlayerGamesEntry.new(game_id: "0022400001")

      assert_equal entry0, entry1
    end

    def test_objects_with_different_game_id_are_not_equal
      entry0 = CumeStatsPlayerGamesEntry.new(game_id: "0022400001")
      entry1 = CumeStatsPlayerGamesEntry.new(game_id: "0022400002")

      refute_equal entry0, entry1
    end
  end
end
