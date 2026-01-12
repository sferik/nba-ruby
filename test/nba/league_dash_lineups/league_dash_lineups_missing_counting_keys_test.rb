require_relative "../../test_helper"

module NBA
  class LeagueDashLineupsMissingCountingKeysTest < Minitest::Test
    cover LeagueDashLineups

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

    def test_handles_missing_plus_minus
      assert_missing_key_returns_nil("PLUS_MINUS", 30, :plus_minus)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "Lineups", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashlineups/).to_return(body: response.to_json)

      stat = LeagueDashLineups.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[GROUP_SET GROUP_ID GROUP_NAME TEAM_ID TEAM_ABBREVIATION GP W L W_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL
        BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def stat_row
      ["5 Man Lineups", "201939-203110", "S. Curry - K. Thompson", Team::GSW, "GSW", 45, 30, 15, 0.667, 245.5,
        8.5, 17.2, 0.494, 3.2, 8.5, 0.376, 3.1, 3.8, 0.816, 1.8, 6.2, 8.0, 5.5, 2.1, 1.5,
        0.8, 0.5, 2.3, 3.1, 23.3, 8.5]
    end
  end
end
