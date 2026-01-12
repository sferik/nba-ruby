require_relative "../../test_helper"

module NBA
  class BoxScoreAdvancedTeamEfficiencyMissingKeysTest < Minitest::Test
    cover BoxScoreAdvanced

    def test_missing_ast_pct
      assert_missing_key_returns_nil("AST_PCT", 12, :ast_pct)
    end

    def test_missing_ast_tov
      assert_missing_key_returns_nil("AST_TOV", 13, :ast_tov)
    end

    def test_missing_ast_ratio
      assert_missing_key_returns_nil("AST_RATIO", 14, :ast_ratio)
    end

    def test_missing_oreb_pct
      assert_missing_key_returns_nil("OREB_PCT", 15, :oreb_pct)
    end

    def test_missing_dreb_pct
      assert_missing_key_returns_nil("DREB_PCT", 16, :dreb_pct)
    end

    def test_missing_reb_pct
      assert_missing_key_returns_nil("REB_PCT", 17, :reb_pct)
    end

    def test_missing_tov_pct
      assert_missing_key_returns_nil("TM_TOV_PCT", 18, :tov_pct)
    end

    def test_missing_efg_pct
      assert_missing_key_returns_nil("EFG_PCT", 19, :efg_pct)
    end

    def test_missing_ts_pct
      assert_missing_key_returns_nil("TS_PCT", 20, :ts_pct)
    end

    def test_missing_e_pace
      assert_missing_key_returns_nil("E_PACE", 21, :e_pace)
    end

    def test_missing_pace
      assert_missing_key_returns_nil("PACE", 22, :pace)
    end

    def test_missing_pace_per40
      assert_missing_key_returns_nil("PACE_PER40", 23, :pace_per40)
    end

    def test_missing_poss
      assert_missing_key_returns_nil("POSS", 24, :poss)
    end

    def test_missing_pie
      assert_missing_key_returns_nil("PIE", 25, :pie)
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
