require_relative "../test_helper"

module NBA
  class LeagueDashPlayerClutchMissingCountingKeysTest < Minitest::Test
    cover LeagueDashPlayerClutch

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

    def test_handles_missing_pf
      assert_missing_key_returns_nil("PF", 26, :pf)
    end

    def test_handles_missing_pts
      assert_missing_key_returns_nil("PTS", 27, :pts)
    end

    def test_handles_missing_plus_minus
      assert_missing_key_returns_nil("PLUS_MINUS", 28, :plus_minus)
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
