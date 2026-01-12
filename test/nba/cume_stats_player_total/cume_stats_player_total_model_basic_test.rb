require_relative "../../test_helper"

module NBA
  class CumeStatsPlayerTotalModelBasicTest < Minitest::Test
    cover CumeStatsPlayerTotal

    def test_equality_based_on_player_id
      total1 = CumeStatsPlayerTotal.new(player_id: 201_939)
      total2 = CumeStatsPlayerTotal.new(player_id: 201_939)
      total3 = CumeStatsPlayerTotal.new(player_id: 201_940)

      assert_equal total1, total2
      refute_equal total1, total3
    end

    def test_has_player_id_attribute
      total = CumeStatsPlayerTotal.new(player_id: 201_939)

      assert_equal 201_939, total.player_id
    end

    def test_has_player_name_attribute
      total = CumeStatsPlayerTotal.new(player_name: "Stephen Curry")

      assert_equal "Stephen Curry", total.player_name
    end

    def test_has_jersey_num_attribute
      total = CumeStatsPlayerTotal.new(jersey_num: "30")

      assert_equal "30", total.jersey_num
    end

    def test_has_season_attribute
      total = CumeStatsPlayerTotal.new(season: "2024-25")

      assert_equal "2024-25", total.season
    end

    def test_has_gp_attribute
      total = CumeStatsPlayerTotal.new(gp: 5)

      assert_equal 5, total.gp
    end

    def test_has_gs_attribute
      total = CumeStatsPlayerTotal.new(gs: 5)

      assert_equal 5, total.gs
    end

    def test_has_actual_minutes_attribute
      total = CumeStatsPlayerTotal.new(actual_minutes: 175)

      assert_equal 175, total.actual_minutes
    end

    def test_has_actual_seconds_attribute
      total = CumeStatsPlayerTotal.new(actual_seconds: 42)

      assert_equal 42, total.actual_seconds
    end
  end
end
