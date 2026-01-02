require_relative "../test_helper"

module NBA
  class BoxScoreUsagePlayerMissingIdentityKeysTest < Minitest::Test
    cover BoxScoreUsage

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

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = player_headers.reject { |h| h == key }
      row = player_row[0...index] + player_row[(index + 1)..]
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)
      stat = BoxScoreUsage.player_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN USG_PCT PCT_FGM PCT_FGA PCT_FG3M PCT_FG3A PCT_FTM PCT_FTA PCT_OREB PCT_DREB PCT_REB
        PCT_AST PCT_TOV PCT_STL PCT_BLK PCT_BLKA PCT_PF PCT_PFD PCT_PTS]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 0.28, 0.25, 0.22, 0.35, 0.30, 0.20, 0.18, 0.05, 0.12, 0.10,
        0.30, 0.15, 0.08, 0.02, 0.03, 0.10, 0.15, 0.28]
    end
  end
end
