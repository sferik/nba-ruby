require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerPtShotMissingShootingKeysTest < Minitest::Test
    cover LeagueDashPlayerPtShot

    def test_handles_missing_fga_frequency
      assert_missing_key_returns_nil("FGA_FREQUENCY", 7, :fga_frequency)
    end

    def test_handles_missing_fgm
      assert_missing_key_returns_nil("FGM", 8, :fgm)
    end

    def test_handles_missing_fga
      assert_missing_key_returns_nil("FGA", 9, :fga)
    end

    def test_handles_missing_fg_pct
      assert_missing_key_returns_nil("FG_PCT", 10, :fg_pct)
    end

    def test_handles_missing_efg_pct
      assert_missing_key_returns_nil("EFG_PCT", 11, :efg_pct)
    end

    def test_handles_missing_fg2a_frequency
      assert_missing_key_returns_nil("FG2A_FREQUENCY", 12, :fg2a_frequency)
    end

    def test_handles_missing_fg2m
      assert_missing_key_returns_nil("FG2M", 13, :fg2m)
    end

    def test_handles_missing_fg2a
      assert_missing_key_returns_nil("FG2A", 14, :fg2a)
    end

    def test_handles_missing_fg2_pct
      assert_missing_key_returns_nil("FG2_PCT", 15, :fg2_pct)
    end

    def test_handles_missing_fg3a_frequency
      assert_missing_key_returns_nil("FG3A_FREQUENCY", 16, :fg3a_frequency)
    end

    def test_handles_missing_fg3m
      assert_missing_key_returns_nil("FG3M", 17, :fg3m)
    end

    def test_handles_missing_fg3a
      assert_missing_key_returns_nil("FG3A", 18, :fg3a)
    end

    def test_handles_missing_fg3_pct
      assert_missing_key_returns_nil("FG3_PCT", 19, :fg3_pct)
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
