require_relative "../test_helper"

module NBA
  class LeagueDashPlayerStatsMissingAdvancedKeysTest < Minitest::Test
    cover LeagueDashPlayerStats

    def test_handles_missing_plus_minus
      assert_missing_key_returns_nil("PLUS_MINUS", 30, :plus_minus)
    end

    def test_handles_missing_nba_fantasy_pts
      assert_missing_key_returns_nil("NBA_FANTASY_PTS", 31, :nba_fantasy_pts)
    end

    def test_handles_missing_dd2
      assert_missing_key_returns_nil("DD2", 32, :dd2)
    end

    def test_handles_missing_td3
      assert_missing_key_returns_nil("TD3", 33, :td3)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueDashPlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashplayerstats/).to_return(body: response.to_json)

      stat = LeagueDashPlayerStats.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE GP W L W_PCT MIN FGM FGA FG_PCT
        FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS
        PLUS_MINUS NBA_FANTASY_PTS DD2 TD3]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36, 72, 46, 26, 0.639, 34.5, 9.2, 19.8, 0.465,
        4.8, 11.2, 0.429, 5.1, 5.5, 0.927, 0.5, 4.3, 4.8, 5.1, 3.2, 0.9, 0.4, 0.3, 2.1, 4.2, 28.3,
        5.2, 45.6, 12, 0]
    end
  end
end
