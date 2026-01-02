require_relative "../test_helper"

module NBA
  class LeagueDashPlayerStatsMissingCountingKeysTest < Minitest::Test
    cover LeagueDashPlayerStats

    def test_handles_missing_oreb
      assert_missing_key_returns_nil("OREB", 19, :oreb)
    end

    def test_handles_missing_dreb
      assert_missing_key_returns_nil("DREB", 20, :dreb)
    end

    def test_handles_missing_reb
      assert_missing_key_returns_nil("REB", 21, :reb)
    end

    def test_handles_missing_ast
      assert_missing_key_returns_nil("AST", 22, :ast)
    end

    def test_handles_missing_tov
      assert_missing_key_returns_nil("TOV", 23, :tov)
    end

    def test_handles_missing_stl
      assert_missing_key_returns_nil("STL", 24, :stl)
    end

    def test_handles_missing_blk
      assert_missing_key_returns_nil("BLK", 25, :blk)
    end

    def test_handles_missing_blka
      assert_missing_key_returns_nil("BLKA", 26, :blka)
    end

    def test_handles_missing_pf
      assert_missing_key_returns_nil("PF", 27, :pf)
    end

    def test_handles_missing_pfd
      assert_missing_key_returns_nil("PFD", 28, :pfd)
    end

    def test_handles_missing_pts
      assert_missing_key_returns_nil("PTS", 29, :pts)
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
