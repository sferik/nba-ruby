require_relative "../../test_helper"

module NBA
  class BoxScoreAdvancedTeamIdentityMissingKeysTest < Minitest::Test
    cover BoxScoreAdvanced

    def test_missing_game_id
      assert_missing_key_returns_nil("GAME_ID", 0, :game_id)
    end

    def test_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 1, :team_id)
    end

    def test_missing_team_name
      assert_missing_key_returns_nil("TEAM_NAME", 2, :team_name)
    end

    def test_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 3, :team_abbreviation)
    end

    def test_missing_team_city
      assert_missing_key_returns_nil("TEAM_CITY", 4, :team_city)
    end

    def test_missing_min
      assert_missing_key_returns_nil("MIN", 5, :min)
    end

    def test_missing_e_off_rating
      assert_missing_key_returns_nil("E_OFF_RATING", 6, :e_off_rating)
    end

    def test_missing_off_rating
      assert_missing_key_returns_nil("OFF_RATING", 7, :off_rating)
    end

    def test_missing_e_def_rating
      assert_missing_key_returns_nil("E_DEF_RATING", 8, :e_def_rating)
    end

    def test_missing_def_rating
      assert_missing_key_returns_nil("DEF_RATING", 9, :def_rating)
    end

    def test_missing_e_net_rating
      assert_missing_key_returns_nil("E_NET_RATING", 10, :e_net_rating)
    end

    def test_missing_net_rating
      assert_missing_key_returns_nil("NET_RATING", 11, :net_rating)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = team_headers.reject { |h| h == key }
      row = team_row[0...index] + team_row[(index + 1)..]
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)
      stat = BoxScoreAdvanced.team_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN E_OFF_RATING OFF_RATING
        E_DEF_RATING DEF_RATING E_NET_RATING NET_RATING AST_PCT AST_TOV AST_RATIO
        OREB_PCT DREB_PCT REB_PCT TM_TOV_PCT EFG_PCT TS_PCT E_PACE PACE PACE_PER40 POSS PIE]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        115.0, 118.0, 105.0, 108.0, 10.0, 10.0, 0.60, 2.0, 0.30,
        0.25, 0.75, 0.50, 0.12, 0.55, 0.58, 98.0, 100.0, 102.0, 200, 0.55]
    end
  end
end
