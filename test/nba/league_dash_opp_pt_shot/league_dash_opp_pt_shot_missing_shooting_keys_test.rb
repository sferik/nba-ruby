require_relative "../../test_helper"

module NBA
  class LeagueDashOppPtShotMissingShootingKeysTest < Minitest::Test
    cover LeagueDashOppPtShot

    def test_handles_missing_fga_frequency
      assert_missing_key_returns_nil("FGA_FREQUENCY", 5, :fga_frequency)
    end

    def test_handles_missing_fgm
      assert_missing_key_returns_nil("FGM", 6, :fgm)
    end

    def test_handles_missing_fga
      assert_missing_key_returns_nil("FGA", 7, :fga)
    end

    def test_handles_missing_fg_pct
      assert_missing_key_returns_nil("FG_PCT", 8, :fg_pct)
    end

    def test_handles_missing_efg_pct
      assert_missing_key_returns_nil("EFG_PCT", 9, :efg_pct)
    end

    def test_handles_missing_fg2a_frequency
      assert_missing_key_returns_nil("FG2A_FREQUENCY", 10, :fg2a_frequency)
    end

    def test_handles_missing_fg2m
      assert_missing_key_returns_nil("FG2M", 11, :fg2m)
    end

    def test_handles_missing_fg2a
      assert_missing_key_returns_nil("FG2A", 12, :fg2a)
    end

    def test_handles_missing_fg2_pct
      assert_missing_key_returns_nil("FG2_PCT", 13, :fg2_pct)
    end

    def test_handles_missing_fg3a_frequency
      assert_missing_key_returns_nil("FG3A_FREQUENCY", 14, :fg3a_frequency)
    end

    def test_handles_missing_fg3m
      assert_missing_key_returns_nil("FG3M", 15, :fg3m)
    end

    def test_handles_missing_fg3a
      assert_missing_key_returns_nil("FG3A", 16, :fg3a)
    end

    def test_handles_missing_fg3_pct
      assert_missing_key_returns_nil("FG3_PCT", 17, :fg3_pct)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueDashPTShots", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashoppptshot/).to_return(body: response.to_json)

      stat = LeagueDashOppPtShot.all(season: 2024).first

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
