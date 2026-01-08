require_relative "../test_helper"

module NBA
  class LeagueDashPlayerClutchMissingShootingKeysTest < Minitest::Test
    cover LeagueDashPlayerClutch

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
      response = {resultSets: [{name: "LeagueDashPlayerClutch", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: response.to_json)

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE GP W L W_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK PF PTS PLUS_MINUS]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36, 74, 46, 28, 0.622, 5.2,
        1.2, 2.8, 0.429, 0.5, 1.4, 0.357, 0.8, 0.9, 0.889,
        0.1, 0.5, 0.6, 1.0, 0.4, 0.2, 0.1, 0.3, 3.7, 1.2]
    end
  end
end
