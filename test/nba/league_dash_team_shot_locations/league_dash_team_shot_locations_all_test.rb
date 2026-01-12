require_relative "../../test_helper"

module NBA
  class LeagueDashTeamShotLocationsAllTest < Minitest::Test
    cover LeagueDashTeamShotLocations

    def test_returns_collection
      stub_shot_locations_request

      result = LeagueDashTeamShotLocations.all(season: 2024)

      assert_instance_of Collection, result
    end

    def test_returns_shot_location_stats
      stub_shot_locations_request

      stats = LeagueDashTeamShotLocations.all(season: 2024)

      assert_instance_of LeagueDashTeamShotLocationStat, stats.first
    end

    def test_accepts_season_type_parameter
      stub_shot_locations_request(season_type: "Playoffs")

      stats = LeagueDashTeamShotLocations.all(season: 2024, season_type: LeagueDashTeamShotLocations::PLAYOFFS)

      assert_instance_of LeagueDashTeamShotLocationStat, stats.first
    end

    def test_accepts_per_mode_parameter
      stub_shot_locations_request(per_mode: "Totals")

      stats = LeagueDashTeamShotLocations.all(season: 2024, per_mode: LeagueDashTeamShotLocations::TOTALS)

      assert_instance_of LeagueDashTeamShotLocationStat, stats.first
    end

    def test_accepts_distance_range_parameter
      stub_shot_locations_request(distance_range: "By Zone")

      stats = LeagueDashTeamShotLocations.all(season: 2024, distance_range: LeagueDashTeamShotLocations::BY_ZONE)

      assert_instance_of LeagueDashTeamShotLocationStat, stats.first
    end

    def test_accepts_custom_client
      custom_client = Minitest::Mock.new
      custom_client.expect :get, shot_locations_response.to_json, [String]

      LeagueDashTeamShotLocations.all(season: 2024, client: custom_client)

      custom_client.verify
    end

    private

    def stub_shot_locations_request(season_type: nil, per_mode: nil, distance_range: nil)
      pattern = build_request_pattern(season_type, per_mode, distance_range)
      stub_request(:get, pattern).to_return(body: shot_locations_response.to_json)
    end

    def build_request_pattern(season_type, per_mode, distance_range)
      return /leaguedashteamshotlocations.*SeasonType=#{season_type.gsub(" ", "%20")}/ if season_type
      return /leaguedashteamshotlocations.*PerMode=#{per_mode}/ if per_mode
      return /leaguedashteamshotlocations.*DistanceRange=#{distance_range.gsub(" ", "%20")}/ if distance_range

      /leaguedashteamshotlocations/
    end

    def shot_locations_response
      {resultSets: [{name: "ShotLocations", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      [{columnNames: %w[TEAM_ID TEAM_NAME]},
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
      [Team::GSW, "Golden State Warriors",
        15.2, 24.8, 0.613, 5.8, 14.2, 0.408, 4.5, 11.3, 0.398,
        1.2, 3.1, 0.387, 1.1, 2.8, 0.393, 9.2, 25.8, 0.357,
        0.0, 0.2, 0.0, 2.3, 5.9, 0.390]
    end
  end
end
