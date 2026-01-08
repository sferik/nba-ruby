require_relative "../test_helper"

module NBA
  class LeagueDashTeamClutchMissingCountingKeysTest < Minitest::Test
    cover LeagueDashTeamClutch

    def test_handles_missing_oreb
      assert_missing_key_returns_nil("OREB", 16, :oreb)
    end

    def test_handles_missing_dreb
      assert_missing_key_returns_nil("DREB", 17, :dreb)
    end

    def test_handles_missing_reb
      assert_missing_key_returns_nil("REB", 18, :reb)
    end

    def test_handles_missing_ast
      assert_missing_key_returns_nil("AST", 19, :ast)
    end

    def test_handles_missing_tov
      assert_missing_key_returns_nil("TOV", 20, :tov)
    end

    def test_handles_missing_stl
      assert_missing_key_returns_nil("STL", 21, :stl)
    end

    def test_handles_missing_blk
      assert_missing_key_returns_nil("BLK", 22, :blk)
    end

    def test_handles_missing_pf
      assert_missing_key_returns_nil("PF", 23, :pf)
    end

    def test_handles_missing_pts
      assert_missing_key_returns_nil("PTS", 24, :pts)
    end

    def test_handles_missing_plus_minus
      assert_missing_key_returns_nil("PLUS_MINUS", 25, :plus_minus)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueDashTeamClutch", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashteamclutch/).to_return(body: response.to_json)

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK PF PTS PLUS_MINUS]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", 82, 46, 36, 0.561, 5.0, 3.2, 7.5, 0.427, 1.2, 3.5, 0.343,
        2.0, 2.5, 0.800, 0.8, 2.2, 3.0, 1.8, 1.2, 0.6, 0.3, 1.5, 9.6, 0.8]
    end
  end
end
