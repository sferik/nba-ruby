require_relative "../test_helper"

module NBA
  class BoxScoreUsageTeamMissingKeysTest < Minitest::Test
    cover BoxScoreUsage

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

    def test_missing_usg_pct
      assert_missing_key_returns_nil("USG_PCT", 6, :usg_pct)
    end

    def test_missing_pct_fgm
      assert_missing_key_returns_nil("PCT_FGM", 7, :pct_fgm)
    end

    def test_missing_pct_fga
      assert_missing_key_returns_nil("PCT_FGA", 8, :pct_fga)
    end

    def test_missing_pct_fg3m
      assert_missing_key_returns_nil("PCT_FG3M", 9, :pct_fg3m)
    end

    def test_missing_pct_fg3a
      assert_missing_key_returns_nil("PCT_FG3A", 10, :pct_fg3a)
    end

    def test_missing_pct_ftm
      assert_missing_key_returns_nil("PCT_FTM", 11, :pct_ftm)
    end

    def test_missing_pct_fta
      assert_missing_key_returns_nil("PCT_FTA", 12, :pct_fta)
    end

    def test_missing_pct_oreb
      assert_missing_key_returns_nil("PCT_OREB", 13, :pct_oreb)
    end

    def test_missing_pct_dreb
      assert_missing_key_returns_nil("PCT_DREB", 14, :pct_dreb)
    end

    def test_missing_pct_reb
      assert_missing_key_returns_nil("PCT_REB", 15, :pct_reb)
    end

    def test_missing_pct_ast
      assert_missing_key_returns_nil("PCT_AST", 16, :pct_ast)
    end

    def test_missing_pct_tov
      assert_missing_key_returns_nil("PCT_TOV", 17, :pct_tov)
    end

    def test_missing_pct_stl
      assert_missing_key_returns_nil("PCT_STL", 18, :pct_stl)
    end

    def test_missing_pct_blk
      assert_missing_key_returns_nil("PCT_BLK", 19, :pct_blk)
    end

    def test_missing_pct_blka
      assert_missing_key_returns_nil("PCT_BLKA", 20, :pct_blka)
    end

    def test_missing_pct_pf
      assert_missing_key_returns_nil("PCT_PF", 21, :pct_pf)
    end

    def test_missing_pct_pfd
      assert_missing_key_returns_nil("PCT_PFD", 22, :pct_pfd)
    end

    def test_missing_pct_pts
      assert_missing_key_returns_nil("PCT_PTS", 23, :pct_pts)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = team_headers.reject { |h| h == key }
      row = team_row[0...index] + team_row[(index + 1)..]
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)
      stat = BoxScoreUsage.team_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN USG_PCT PCT_FGM PCT_FGA
        PCT_FG3M PCT_FG3A PCT_FTM PCT_FTA PCT_OREB PCT_DREB PCT_REB PCT_AST PCT_TOV
        PCT_STL PCT_BLK PCT_BLKA PCT_PF PCT_PFD PCT_PTS]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        1.0, 0.45, 0.50, 0.35, 0.40, 0.80, 0.85, 0.25, 0.75, 0.50, 0.60, 0.40, 0.55, 0.45, 0.30, 0.65, 0.35, 0.52]
    end
  end
end
