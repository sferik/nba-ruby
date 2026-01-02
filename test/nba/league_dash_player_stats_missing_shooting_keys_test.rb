require_relative "../test_helper"

module NBA
  class LeagueDashPlayerStatsMissingShootingKeysTest < Minitest::Test
    cover LeagueDashPlayerStats

    def test_handles_missing_fgm
      assert_missing_key_returns_nil("FGM", 10, :fgm)
    end

    def test_handles_missing_fga
      assert_missing_key_returns_nil("FGA", 11, :fga)
    end

    def test_handles_missing_fg_pct
      assert_missing_key_returns_nil("FG_PCT", 12, :fg_pct)
    end

    def test_handles_missing_fg3m
      assert_missing_key_returns_nil("FG3M", 13, :fg3m)
    end

    def test_handles_missing_fg3a
      assert_missing_key_returns_nil("FG3A", 14, :fg3a)
    end

    def test_handles_missing_fg3_pct
      assert_missing_key_returns_nil("FG3_PCT", 15, :fg3_pct)
    end

    def test_handles_missing_ftm
      assert_missing_key_returns_nil("FTM", 16, :ftm)
    end

    def test_handles_missing_fta
      assert_missing_key_returns_nil("FTA", 17, :fta)
    end

    def test_handles_missing_ft_pct
      assert_missing_key_returns_nil("FT_PCT", 18, :ft_pct)
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
