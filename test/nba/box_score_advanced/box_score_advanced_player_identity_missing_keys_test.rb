require_relative "../../test_helper"

module NBA
  class BoxScoreAdvancedPlayerIdentityMissingKeysTest < Minitest::Test
    cover BoxScoreAdvanced

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

    def test_missing_e_off_rating
      assert_missing_key_returns_nil("E_OFF_RATING", 9, :e_off_rating)
    end

    def test_missing_off_rating
      assert_missing_key_returns_nil("OFF_RATING", 10, :off_rating)
    end

    def test_missing_e_def_rating
      assert_missing_key_returns_nil("E_DEF_RATING", 11, :e_def_rating)
    end

    def test_missing_def_rating
      assert_missing_key_returns_nil("DEF_RATING", 12, :def_rating)
    end

    def test_missing_e_net_rating
      assert_missing_key_returns_nil("E_NET_RATING", 13, :e_net_rating)
    end

    def test_missing_net_rating
      assert_missing_key_returns_nil("NET_RATING", 14, :net_rating)
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
