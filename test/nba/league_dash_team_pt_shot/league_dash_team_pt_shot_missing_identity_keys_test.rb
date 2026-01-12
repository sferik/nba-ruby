require_relative "../../test_helper"

module NBA
  class LeagueDashTeamPtShotMissingIdentityKeysTest < Minitest::Test
    cover LeagueDashTeamPtShot

    def test_handles_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 0, :team_id)
    end

    def test_handles_missing_team_name
      assert_missing_key_returns_nil("TEAM_NAME", 1, :team_name)
    end

    def test_handles_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 2, :team_abbreviation)
    end

    def test_handles_missing_gp
      assert_missing_key_returns_nil("GP", 3, :gp)
    end

    def test_handles_missing_g
      assert_missing_key_returns_nil("G", 4, :g)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueDashPTShots", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashteamptshot/).to_return(body: response.to_json)

      stat = LeagueDashTeamPtShot.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION GP G FGA_FREQUENCY FGM FGA FG_PCT EFG_PCT
        FG2A_FREQUENCY FG2M FG2A FG2_PCT FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", "GSW", 82, 82, 1.0, 42.5, 89.2, 0.477, 0.563,
        0.45, 20.2, 41.1, 0.492, 0.55, 15.3, 40.1, 0.382]
    end
  end
end
