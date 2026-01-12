require_relative "../../test_helper"

module NBA
  class LeagueDashPtStatsMissingIdentityKeysTest < Minitest::Test
    cover LeagueDashPtStats

    def test_handles_missing_player_id
      assert_missing_key_returns_nil("PLAYER_ID", 0, :player_id)
    end

    def test_handles_missing_player_name
      assert_missing_key_returns_nil("PLAYER_NAME", 1, :player_name)
    end

    def test_handles_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 2, :team_id)
    end

    def test_handles_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 3, :team_abbreviation)
    end

    def test_handles_missing_team_name
      assert_missing_key_returns_nil("TEAM_NAME", 4, :team_name)
    end

    def test_handles_missing_age
      assert_missing_key_returns_nil("AGE", 5, :age)
    end

    def test_handles_missing_gp
      assert_missing_key_returns_nil("GP", 6, :gp)
    end

    def test_handles_missing_w
      assert_missing_key_returns_nil("W", 7, :w)
    end

    def test_handles_missing_l
      assert_missing_key_returns_nil("L", 8, :l)
    end

    def test_handles_missing_min
      assert_missing_key_returns_nil("MIN", 9, :min)
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
