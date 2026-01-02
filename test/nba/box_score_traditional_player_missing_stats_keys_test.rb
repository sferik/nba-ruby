require_relative "../test_helper"

module NBA
  class BoxScoreTraditionalPlayerMissingStatsKeysTest < Minitest::Test
    cover BoxScoreTraditional

    def test_missing_fgm
      assert_missing_key_returns_nil("FGM", 9, :fgm)
    end

    def test_missing_fga
      assert_missing_key_returns_nil("FGA", 10, :fga)
    end

    def test_missing_fg_pct
      assert_missing_key_returns_nil("FG_PCT", 11, :fg_pct)
    end

    def test_missing_fg3m
      assert_missing_key_returns_nil("FG3M", 12, :fg3m)
    end

    def test_missing_fg3a
      assert_missing_key_returns_nil("FG3A", 13, :fg3a)
    end

    def test_missing_fg3_pct
      assert_missing_key_returns_nil("FG3_PCT", 14, :fg3_pct)
    end

    def test_missing_ftm
      assert_missing_key_returns_nil("FTM", 15, :ftm)
    end

    def test_missing_fta
      assert_missing_key_returns_nil("FTA", 16, :fta)
    end

    def test_missing_ft_pct
      assert_missing_key_returns_nil("FT_PCT", 17, :ft_pct)
    end

    def test_missing_oreb
      assert_missing_key_returns_nil("OREB", 18, :oreb)
    end

    def test_missing_dreb
      assert_missing_key_returns_nil("DREB", 19, :dreb)
    end

    def test_missing_reb
      assert_missing_key_returns_nil("REB", 20, :reb)
    end

    def test_missing_ast
      assert_missing_key_returns_nil("AST", 21, :ast)
    end

    def test_missing_stl
      assert_missing_key_returns_nil("STL", 22, :stl)
    end

    def test_missing_blk
      assert_missing_key_returns_nil("BLK", 23, :blk)
    end

    def test_missing_tov
      assert_missing_key_returns_nil("TO", 24, :tov)
    end

    def test_missing_pf
      assert_missing_key_returns_nil("PF", 25, :pf)
    end

    def test_missing_pts
      assert_missing_key_returns_nil("PTS", 26, :pts)
    end

    def test_missing_plus_minus
      assert_missing_key_returns_nil("PLUS_MINUS", 27, :plus_minus)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = player_headers.reject { |h| h == key }
      row = player_row[0...index] + player_row[(index + 1)..]
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)
      stat = BoxScoreTraditional.player_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 10, 20, 0.500, 5, 12, 0.417, 6, 6, 1.0, 0, 4, 4, 8, 1, 0, 3, 2, 31, 15]
    end
  end
end
