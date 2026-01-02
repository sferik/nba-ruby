require_relative "../test_helper"

module NBA
  class BoxScoreAdvancedPlayerEfficiencyMissingKeysTest < Minitest::Test
    cover BoxScoreAdvanced

    def test_missing_ast_pct
      assert_missing_key_returns_nil("AST_PCT", 15, :ast_pct)
    end

    def test_missing_ast_tov
      assert_missing_key_returns_nil("AST_TOV", 16, :ast_tov)
    end

    def test_missing_ast_ratio
      assert_missing_key_returns_nil("AST_RATIO", 17, :ast_ratio)
    end

    def test_missing_oreb_pct
      assert_missing_key_returns_nil("OREB_PCT", 18, :oreb_pct)
    end

    def test_missing_dreb_pct
      assert_missing_key_returns_nil("DREB_PCT", 19, :dreb_pct)
    end

    def test_missing_reb_pct
      assert_missing_key_returns_nil("REB_PCT", 20, :reb_pct)
    end

    def test_missing_tov_pct
      assert_missing_key_returns_nil("TM_TOV_PCT", 21, :tov_pct)
    end

    def test_missing_efg_pct
      assert_missing_key_returns_nil("EFG_PCT", 22, :efg_pct)
    end

    def test_missing_ts_pct
      assert_missing_key_returns_nil("TS_PCT", 23, :ts_pct)
    end

    def test_missing_usg_pct
      assert_missing_key_returns_nil("USG_PCT", 24, :usg_pct)
    end

    def test_missing_e_usg_pct
      assert_missing_key_returns_nil("E_USG_PCT", 25, :e_usg_pct)
    end

    def test_missing_e_pace
      assert_missing_key_returns_nil("E_PACE", 26, :e_pace)
    end

    def test_missing_pace
      assert_missing_key_returns_nil("PACE", 27, :pace)
    end

    def test_missing_pace_per40
      assert_missing_key_returns_nil("PACE_PER40", 28, :pace_per40)
    end

    def test_missing_poss
      assert_missing_key_returns_nil("POSS", 29, :poss)
    end

    def test_missing_pie
      assert_missing_key_returns_nil("PIE", 30, :pie)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = player_headers.reject { |h| h == key }
      row = player_row[0...index] + player_row[(index + 1)..]
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)
      stat = BoxScoreAdvanced.player_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN E_OFF_RATING OFF_RATING E_DEF_RATING DEF_RATING E_NET_RATING NET_RATING
        AST_PCT AST_TOV AST_RATIO OREB_PCT DREB_PCT REB_PCT TM_TOV_PCT EFG_PCT TS_PCT
        USG_PCT E_USG_PCT E_PACE PACE PACE_PER40 POSS PIE]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 115.0, 118.0, 105.0, 108.0, 10.0, 10.0, 0.35, 2.5, 0.25, 0.05, 0.15, 0.10,
        0.12, 0.55, 0.60, 0.28, 0.30, 98.0, 100.0, 102.0, 50, 0.15]
    end
  end
end
