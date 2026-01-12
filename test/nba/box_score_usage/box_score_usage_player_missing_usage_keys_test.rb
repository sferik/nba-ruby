require_relative "../../test_helper"

module NBA
  class BoxScoreUsagePlayerMissingUsageKeysTest < Minitest::Test
    cover BoxScoreUsage

    def test_missing_usg_pct
      assert_missing_key_returns_nil("USG_PCT", 9, :usg_pct)
    end

    def test_missing_pct_fgm
      assert_missing_key_returns_nil("PCT_FGM", 10, :pct_fgm)
    end

    def test_missing_pct_fga
      assert_missing_key_returns_nil("PCT_FGA", 11, :pct_fga)
    end

    def test_missing_pct_fg3m
      assert_missing_key_returns_nil("PCT_FG3M", 12, :pct_fg3m)
    end

    def test_missing_pct_fg3a
      assert_missing_key_returns_nil("PCT_FG3A", 13, :pct_fg3a)
    end

    def test_missing_pct_ftm
      assert_missing_key_returns_nil("PCT_FTM", 14, :pct_ftm)
    end

    def test_missing_pct_fta
      assert_missing_key_returns_nil("PCT_FTA", 15, :pct_fta)
    end

    def test_missing_pct_oreb
      assert_missing_key_returns_nil("PCT_OREB", 16, :pct_oreb)
    end

    def test_missing_pct_dreb
      assert_missing_key_returns_nil("PCT_DREB", 17, :pct_dreb)
    end

    def test_missing_pct_reb
      assert_missing_key_returns_nil("PCT_REB", 18, :pct_reb)
    end

    def test_missing_pct_ast
      assert_missing_key_returns_nil("PCT_AST", 19, :pct_ast)
    end

    def test_missing_pct_tov
      assert_missing_key_returns_nil("PCT_TOV", 20, :pct_tov)
    end

    def test_missing_pct_stl
      assert_missing_key_returns_nil("PCT_STL", 21, :pct_stl)
    end

    def test_missing_pct_blk
      assert_missing_key_returns_nil("PCT_BLK", 22, :pct_blk)
    end

    def test_missing_pct_blka
      assert_missing_key_returns_nil("PCT_BLKA", 23, :pct_blka)
    end

    def test_missing_pct_pf
      assert_missing_key_returns_nil("PCT_PF", 24, :pct_pf)
    end

    def test_missing_pct_pfd
      assert_missing_key_returns_nil("PCT_PFD", 25, :pct_pfd)
    end

    def test_missing_pct_pts
      assert_missing_key_returns_nil("PCT_PTS", 26, :pct_pts)
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
