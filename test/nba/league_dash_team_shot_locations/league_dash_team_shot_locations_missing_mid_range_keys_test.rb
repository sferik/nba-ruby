require_relative "../../test_helper"

module NBA
  class LeagueDashTeamShotLocationsMissingMidRangeKeysTest < Minitest::Test
    cover LeagueDashTeamShotLocations

    def test_handles_missing_mid_range_fgm
      assert_missing_key_returns_nil("Mid-Range FGM", 8, :mid_range_fgm)
    end

    def test_handles_missing_mid_range_fga
      assert_missing_key_returns_nil("Mid-Range FGA", 9, :mid_range_fga)
    end

    def test_handles_missing_mid_range_fg_pct
      assert_missing_key_returns_nil("Mid-Range FG_PCT", 10, :mid_range_fg_pct)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers_without(key)
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "ShotLocations", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashteamshotlocations/).to_return(body: response.to_json)

      stat = LeagueDashTeamShotLocations.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers_without(key)
      flat_headers.reject { |h| h.eql?(key) }.then { |h| [{columnNames: h}] }
    end

    def flat_headers
      %w[TEAM_ID TEAM_NAME] +
        ["Restricted Area FGM", "Restricted Area FGA", "Restricted Area FG_PCT"] +
        ["In The Paint (Non-RA) FGM", "In The Paint (Non-RA) FGA", "In The Paint (Non-RA) FG_PCT"] +
        ["Mid-Range FGM", "Mid-Range FGA", "Mid-Range FG_PCT"] +
        ["Left Corner 3 FGM", "Left Corner 3 FGA", "Left Corner 3 FG_PCT"] +
        ["Right Corner 3 FGM", "Right Corner 3 FGA", "Right Corner 3 FG_PCT"] +
        ["Above the Break 3 FGM", "Above the Break 3 FGA", "Above the Break 3 FG_PCT"] +
        ["Backcourt FGM", "Backcourt FGA", "Backcourt FG_PCT"] +
        ["Corner 3 FGM", "Corner 3 FGA", "Corner 3 FG_PCT"]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors",
        15.2, 24.8, 0.613, 5.8, 14.2, 0.408, 4.5, 11.3, 0.398,
        1.2, 3.1, 0.387, 1.1, 2.8, 0.393, 9.2, 25.8, 0.357,
        0.0, 0.2, 0.0, 2.3, 5.9, 0.390]
    end
  end
end
