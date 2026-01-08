require_relative "../test_helper"

module NBA
  class LeagueDashPlayerClutchMissingIdentityKeysTest < Minitest::Test
    cover LeagueDashPlayerClutch

    def test_handles_missing_player_id
      assert_missing_key_returns_nil("PLAYER_ID", 0, :player_id)
    end

    def test_handles_missing_player_name
      assert_missing_key_returns_nil("PLAYER_NAME", 1, :player_name)
    end

    def test_handles_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 2, :team_id)
    end

    def test_handles_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 3, :team_abbreviation)
    end

    def test_handles_missing_age
      assert_missing_key_returns_nil("AGE", 4, :age)
    end

    def test_handles_missing_gp
      assert_missing_key_returns_nil("GP", 5, :gp)
    end

    def test_handles_missing_w
      assert_missing_key_returns_nil("W", 6, :w)
    end

    def test_handles_missing_l
      assert_missing_key_returns_nil("L", 7, :l)
    end

    def test_handles_missing_w_pct
      assert_missing_key_returns_nil("W_PCT", 8, :w_pct)
    end

    def test_handles_missing_min
      assert_missing_key_returns_nil("MIN", 9, :min)
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
