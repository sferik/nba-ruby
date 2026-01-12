require_relative "../../test_helper"

module NBA
  class LeagueDashTeamShotLocationsDefaultParametersTest < Minitest::Test
    cover LeagueDashTeamShotLocations

    def test_uses_current_season_by_default
      expected_season = Utils.format_season(Utils.current_season)
      stub_request(:get, /Season=#{expected_season}/).to_return(body: shot_locations_response.to_json)

      LeagueDashTeamShotLocations.all

      assert_requested(:get, /Season=#{expected_season}/)
    end

    def test_uses_regular_season_by_default
      stub_request(:get, /SeasonType=Regular%20Season/).to_return(body: shot_locations_response.to_json)

      LeagueDashTeamShotLocations.all

      assert_requested(:get, /SeasonType=Regular%20Season/)
    end

    def test_uses_per_game_by_default
      stub_request(:get, /PerMode=PerGame/).to_return(body: shot_locations_response.to_json)

      LeagueDashTeamShotLocations.all

      assert_requested(:get, /PerMode=PerGame/)
    end

    def test_uses_by_zone_by_default
      stub_request(:get, /DistanceRange=By%20Zone/).to_return(body: shot_locations_response.to_json)

      LeagueDashTeamShotLocations.all

      assert_requested(:get, /DistanceRange=By%20Zone/)
    end

    private

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
