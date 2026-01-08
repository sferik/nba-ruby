require_relative "../test_helper"

module NBA
  class LeagueDashPlayerShotLocationsPaintMappingTest < Minitest::Test
    cover LeagueDashPlayerShotLocations

    def test_maps_in_the_paint_non_ra_fgm
      stub_shot_locations_request

      assert_in_delta 1.2, stat.in_the_paint_non_ra_fgm
    end

    def test_maps_in_the_paint_non_ra_fga
      stub_shot_locations_request

      assert_in_delta 2.8, stat.in_the_paint_non_ra_fga
    end

    def test_maps_in_the_paint_non_ra_fg_pct
      stub_shot_locations_request

      assert_in_delta 0.428, stat.in_the_paint_non_ra_fg_pct
    end

    private

    def stat
      LeagueDashPlayerShotLocations.all(season: 2024).first
    end

    def stub_shot_locations_request
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: shot_locations_response.to_json)
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
