require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerShotLocationsAllTest < Minitest::Test
    cover LeagueDashPlayerShotLocations

    def test_returns_collection
      stub_shot_locations_request

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_instance_of Collection, result
    end

    def test_returns_shot_location_stats
      stub_shot_locations_request

      stats = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_instance_of LeagueDashPlayerShotLocationStat, stats.first
    end

    def test_accepts_season_type_parameter
      stub_shot_locations_request(season_type: "Playoffs")

      stats = LeagueDashPlayerShotLocations.all(season: 2024, season_type: LeagueDashPlayerShotLocations::PLAYOFFS)

      assert_instance_of LeagueDashPlayerShotLocationStat, stats.first
    end

    def test_accepts_per_mode_parameter
      stub_shot_locations_request(per_mode: "Totals")

      stats = LeagueDashPlayerShotLocations.all(season: 2024, per_mode: LeagueDashPlayerShotLocations::TOTALS)

      assert_instance_of LeagueDashPlayerShotLocationStat, stats.first
    end

    def test_accepts_distance_range_parameter
      stub_shot_locations_request(distance_range: "By Zone")

      stats = LeagueDashPlayerShotLocations.all(season: 2024, distance_range: LeagueDashPlayerShotLocations::BY_ZONE)

      assert_instance_of LeagueDashPlayerShotLocationStat, stats.first
    end

    def test_accepts_custom_client
      custom_client = Minitest::Mock.new
      custom_client.expect :get, shot_locations_response.to_json, [String]

      LeagueDashPlayerShotLocations.all(season: 2024, client: custom_client)

      custom_client.verify
    end

    private

    def stub_shot_locations_request(season_type: nil, per_mode: nil, distance_range: nil)
      pattern = if season_type
        /leaguedashplayershotlocations.*SeasonType=#{season_type.gsub(" ", "%20")}/
      elsif per_mode
        /leaguedashplayershotlocations.*PerMode=#{per_mode}/
      elsif distance_range
        /leaguedashplayershotlocations.*DistanceRange=#{distance_range.gsub(" ", "%20")}/
      else
        /leaguedashplayershotlocations/
      end
      stub_request(:get, pattern).to_return(body: shot_locations_response.to_json)
    end

    def shot_locations_response
      {resultSets: [{name: "ShotLocations", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      [{columnNames: %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE]},
        {columnNames: ["Restricted Area FGM", "Restricted Area FGA", "Restricted Area FG_PCT"]},
        {columnNames: ["In The Paint (Non-RA) FGM", "In The Paint (Non-RA) FGA",
          "In The Paint (Non-RA) FG_PCT"]},
        {columnNames: ["Mid-Range FGM", "Mid-Range FGA", "Mid-Range FG_PCT"]},
        {columnNames: ["Left Corner 3 FGM", "Left Corner 3 FGA", "Left Corner 3 FG_PCT"]},
        {columnNames: ["Right Corner 3 FGM", "Right Corner 3 FGA", "Right Corner 3 FG_PCT"]},
        {columnNames: ["Above the Break 3 FGM", "Above the Break 3 FGA", "Above the Break 3 FG_PCT"]},
        {columnNames: ["Backcourt FGM", "Backcourt FGA", "Backcourt FG_PCT"]},
        {columnNames: ["Corner 3 FGM", "Corner 3 FGA", "Corner 3 FG_PCT"]}]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36.0,
        2.5, 4.2, 0.595, 1.2, 2.8, 0.428, 0.8, 2.1, 0.381,
        0.4, 0.9, 0.444, 0.3, 0.7, 0.429, 2.8, 7.2, 0.389,
        0.0, 0.1, 0.0, 0.7, 1.6, 0.438]
    end
  end
end
