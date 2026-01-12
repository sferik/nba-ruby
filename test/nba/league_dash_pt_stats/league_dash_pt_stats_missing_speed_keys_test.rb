require_relative "../../test_helper"

module NBA
  class LeagueDashPtStatsMissingSpeedKeysTest < Minitest::Test
    cover LeagueDashPtStats

    def test_handles_missing_dist_feet
      assert_missing_key_returns_nil("DIST_FEET", 10, :dist_feet)
    end

    def test_handles_missing_dist_miles
      assert_missing_key_returns_nil("DIST_MILES", 11, :dist_miles)
    end

    def test_handles_missing_dist_miles_off
      assert_missing_key_returns_nil("DIST_MILES_OFF", 12, :dist_miles_off)
    end

    def test_handles_missing_dist_miles_def
      assert_missing_key_returns_nil("DIST_MILES_DEF", 13, :dist_miles_def)
    end

    def test_handles_missing_avg_speed
      assert_missing_key_returns_nil("AVG_SPEED", 14, :avg_speed)
    end

    def test_handles_missing_avg_speed_off
      assert_missing_key_returns_nil("AVG_SPEED_OFF", 15, :avg_speed_off)
    end

    def test_handles_missing_avg_speed_def
      assert_missing_key_returns_nil("AVG_SPEED_DEF", 16, :avg_speed_def)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueDashPtStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashptstats/).to_return(body: response.to_json)

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION TEAM_NAME AGE GP W L MIN
        DIST_FEET DIST_MILES DIST_MILES_OFF DIST_MILES_DEF AVG_SPEED AVG_SPEED_OFF AVG_SPEED_DEF]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", "Golden State Warriors", 36.0, 82, 50, 32, 32.5,
        12_500.5, 2.37, 1.15, 1.22, 4.25, 4.15, 4.35]
    end
  end
end
