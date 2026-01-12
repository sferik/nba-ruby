require_relative "../../test_helper"

module NBA
  class CareerStatsEqualityTest < Minitest::Test
    cover CareerStats

    def test_objects_with_same_player_id_and_season_id_are_equal
      stats0 = CareerStats.new(player_id: 201_939, season_id: "2024-25")
      stats1 = CareerStats.new(player_id: 201_939, season_id: "2024-25")

      assert_equal stats0, stats1
    end

    def test_objects_with_different_season_id_are_not_equal
      stats0 = CareerStats.new(player_id: 201_939, season_id: "2024-25")
      stats1 = CareerStats.new(player_id: 201_939, season_id: "2023-24")

      refute_equal stats0, stats1
    end

    def test_objects_with_different_player_id_are_not_equal
      stats0 = CareerStats.new(player_id: 201_939, season_id: "2024-25")
      stats1 = CareerStats.new(player_id: 201_940, season_id: "2024-25")

      refute_equal stats0, stats1
    end
  end
end
