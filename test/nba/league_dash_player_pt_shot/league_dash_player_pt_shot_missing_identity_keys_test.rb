require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerPtShotMissingIdentityKeysTest < Minitest::Test
    cover LeagueDashPlayerPtShot

    def test_handles_missing_player_id
      assert_missing_key_returns_nil("PLAYER_ID", 0, :player_id)
    end

    def test_handles_missing_player_name
      assert_missing_key_returns_nil("PLAYER_NAME", 1, :player_name)
    end

    def test_handles_missing_player_last_team_id
      assert_missing_key_returns_nil("PLAYER_LAST_TEAM_ID", 2, :player_last_team_id)
    end

    def test_handles_missing_player_last_team_abbreviation
      assert_missing_key_returns_nil("PLAYER_LAST_TEAM_ABBREVIATION", 3, :player_last_team_abbreviation)
    end

    def test_handles_missing_age
      assert_missing_key_returns_nil("AGE", 4, :age)
    end

    def test_handles_missing_gp
      assert_missing_key_returns_nil("GP", 5, :gp)
    end

    def test_handles_missing_g
      assert_missing_key_returns_nil("G", 6, :g)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueDashPTShots", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashplayerptshot/).to_return(body: response.to_json)

      stat = LeagueDashPlayerPtShot.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME PLAYER_LAST_TEAM_ID PLAYER_LAST_TEAM_ABBREVIATION AGE GP G
        FGA_FREQUENCY FGM FGA FG_PCT EFG_PCT FG2A_FREQUENCY FG2M FG2A FG2_PCT
        FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36.0, 74, 74, 1.0, 8.5, 18.2, 0.467, 0.563,
        0.45, 4.2, 8.1, 0.519, 0.55, 4.3, 10.1, 0.426]
    end
  end
end
