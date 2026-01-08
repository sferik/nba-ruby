require_relative "../test_helper"

module NBA
  class LeagueDashPlayerShotLocationsMissingMidRangeKeysTest < Minitest::Test
    cover LeagueDashPlayerShotLocations

    def test_handles_missing_mid_range_fgm
      assert_missing_key_returns_nil("Mid-Range FGM", 11, :mid_range_fgm)
    end

    def test_handles_missing_mid_range_fga
      assert_missing_key_returns_nil("Mid-Range FGA", 12, :mid_range_fga)
    end

    def test_handles_missing_mid_range_fg_pct
      assert_missing_key_returns_nil("Mid-Range FG_PCT", 13, :mid_range_fg_pct)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers_without(key)
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "ShotLocations", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: response.to_json)

      stat = LeagueDashPlayerShotLocations.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers_without(key)
      flat_headers.reject { |h| h.eql?(key) }.then { |h| [{columnNames: h}] }
    end

    def flat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE] +
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
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36.0,
        2.5, 4.2, 0.595, 1.2, 2.8, 0.428, 0.8, 2.1, 0.381,
        0.4, 0.9, 0.444, 0.3, 0.7, 0.429, 2.8, 7.2, 0.389,
        0.0, 0.1, 0.0, 0.7, 1.6, 0.438]
    end
  end
end
