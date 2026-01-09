require_relative "../test_helper"

module NBA
  class CumeStatsTeamGamesEntryModelTest < Minitest::Test
    cover CumeStatsTeamGamesEntry

    def test_objects_with_same_game_id_are_equal
      entry0 = CumeStatsTeamGamesEntry.new(game_id: 22_300_001)
      entry1 = CumeStatsTeamGamesEntry.new(game_id: 22_300_001)

      assert_equal entry0, entry1
    end

    def test_objects_with_different_game_id_are_not_equal
      entry0 = CumeStatsTeamGamesEntry.new(game_id: 22_300_001)
      entry1 = CumeStatsTeamGamesEntry.new(game_id: 22_300_002)

      refute_equal entry0, entry1
    end
  end
end
