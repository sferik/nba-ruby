require_relative "../test_helper"

module NBA
  class BoxScoreFourFactorsPlayerMissingKeysTest < Minitest::Test
    cover BoxScoreFourFactors

    def test_missing_game_id
      assert_missing_key_returns_nil("GAME_ID", 0, :game_id)
    end

    def test_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 1, :team_id)
    end

    def test_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 2, :team_abbreviation)
    end

    def test_missing_team_city
      assert_missing_key_returns_nil("TEAM_CITY", 3, :team_city)
    end

    def test_missing_player_id
      assert_missing_key_returns_nil("PLAYER_ID", 4, :player_id)
    end

    def test_missing_player_name
      assert_missing_key_returns_nil("PLAYER_NAME", 5, :player_name)
    end

    def test_missing_start_position
      assert_missing_key_returns_nil("START_POSITION", 6, :start_position)
    end

    def test_missing_comment
      assert_missing_key_returns_nil("COMMENT", 7, :comment)
    end

    def test_missing_min
      assert_missing_key_returns_nil("MIN", 8, :min)
    end

    def test_missing_efg_pct
      assert_missing_key_returns_nil("EFG_PCT", 9, :efg_pct)
    end

    def test_missing_fta_rate
      assert_missing_key_returns_nil("FTA_RATE", 10, :fta_rate)
    end

    def test_missing_tov_pct
      assert_missing_key_returns_nil("TM_TOV_PCT", 11, :tov_pct)
    end

    def test_missing_oreb_pct
      assert_missing_key_returns_nil("OREB_PCT", 12, :oreb_pct)
    end

    def test_missing_opp_efg_pct
      assert_missing_key_returns_nil("OPP_EFG_PCT", 13, :opp_efg_pct)
    end

    def test_missing_opp_fta_rate
      assert_missing_key_returns_nil("OPP_FTA_RATE", 14, :opp_fta_rate)
    end

    def test_missing_opp_tov_pct
      assert_missing_key_returns_nil("OPP_TOV_PCT", 15, :opp_tov_pct)
    end

    def test_missing_opp_oreb_pct
      assert_missing_key_returns_nil("OPP_OREB_PCT", 16, :opp_oreb_pct)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = player_headers.reject { |h| h == key }
      row = player_row[0...index] + player_row[(index + 1)..]
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscorefourfactorsv2/).to_return(body: response.to_json)
      stat = BoxScoreFourFactors.player_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN EFG_PCT FTA_RATE TM_TOV_PCT OREB_PCT OPP_EFG_PCT OPP_FTA_RATE OPP_TOV_PCT OPP_OREB_PCT]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 0.58, 0.25, 0.12, 0.08, 0.52, 0.22, 0.14, 0.10]
    end
  end
end
