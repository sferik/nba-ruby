require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerShotLocationsConstantsTest < Minitest::Test
    cover LeagueDashPlayerShotLocations

    def test_shot_locations_constant
      assert_equal "ShotLocations", LeagueDashPlayerShotLocations::SHOT_LOCATIONS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashPlayerShotLocations::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashPlayerShotLocations::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashPlayerShotLocations::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashPlayerShotLocations::TOTALS
    end

    def test_by_zone_constant
      assert_equal "By Zone", LeagueDashPlayerShotLocations::BY_ZONE
    end
  end
end
