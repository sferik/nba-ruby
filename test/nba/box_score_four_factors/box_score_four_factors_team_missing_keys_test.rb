require_relative "../../test_helper"

module NBA
  class BoxScoreFourFactorsTeamMissingKeysTest < Minitest::Test
    cover BoxScoreFourFactors

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

    def test_missing_efg_pct
      assert_missing_key_returns_nil("EFG_PCT", 6, :efg_pct)
    end

    def test_missing_fta_rate
      assert_missing_key_returns_nil("FTA_RATE", 7, :fta_rate)
    end

    def test_missing_tov_pct
      assert_missing_key_returns_nil("TM_TOV_PCT", 8, :tov_pct)
    end

    def test_missing_oreb_pct
      assert_missing_key_returns_nil("OREB_PCT", 9, :oreb_pct)
    end

    def test_missing_opp_efg_pct
      assert_missing_key_returns_nil("OPP_EFG_PCT", 10, :opp_efg_pct)
    end

    def test_missing_opp_fta_rate
      assert_missing_key_returns_nil("OPP_FTA_RATE", 11, :opp_fta_rate)
    end

    def test_missing_opp_tov_pct
      assert_missing_key_returns_nil("OPP_TOV_PCT", 12, :opp_tov_pct)
    end

    def test_missing_opp_oreb_pct
      assert_missing_key_returns_nil("OPP_OREB_PCT", 13, :opp_oreb_pct)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = team_headers.reject { |h| h == key }
      row = team_row[0...index] + team_row[(index + 1)..]
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: response.to_json)
      stat = BoxScoreFourFactors.team_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN EFG_PCT FTA_RATE
        TM_TOV_PCT OREB_PCT OPP_EFG_PCT OPP_FTA_RATE OPP_TOV_PCT OPP_OREB_PCT]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        0.56, 0.28, 0.11, 0.25, 0.50, 0.24, 0.15, 0.22]
    end
  end
end
