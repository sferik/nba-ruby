require_relative "../../test_helper"

module NBA
  class LeagueDashTeamShotLocationsConstantsTest < Minitest::Test
    cover LeagueDashTeamShotLocations

    def test_shot_locations_constant
      assert_equal "ShotLocations", LeagueDashTeamShotLocations::SHOT_LOCATIONS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueDashTeamShotLocations::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueDashTeamShotLocations::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueDashTeamShotLocations::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueDashTeamShotLocations::TOTALS
    end

    def test_by_zone_constant
      assert_equal "By Zone", LeagueDashTeamShotLocations::BY_ZONE
    end
  end
end
