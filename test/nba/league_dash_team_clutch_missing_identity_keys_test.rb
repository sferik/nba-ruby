require_relative "../test_helper"

module NBA
  class LeagueDashTeamClutchMissingIdentityKeysTest < Minitest::Test
    cover LeagueDashTeamClutch

    def test_handles_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 0, :team_id)
    end

    def test_handles_missing_team_name
      assert_missing_key_returns_nil("TEAM_NAME", 1, :team_name)
    end

    def test_handles_missing_gp
      assert_missing_key_returns_nil("GP", 2, :gp)
    end

    def test_handles_missing_w
      assert_missing_key_returns_nil("W", 3, :w)
    end

    def test_handles_missing_l
      assert_missing_key_returns_nil("L", 4, :l)
    end

    def test_handles_missing_w_pct
      assert_missing_key_returns_nil("W_PCT", 5, :w_pct)
    end

    def test_handles_missing_min
      assert_missing_key_returns_nil("MIN", 6, :min)
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
