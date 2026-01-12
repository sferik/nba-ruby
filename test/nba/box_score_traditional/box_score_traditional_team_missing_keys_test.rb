require_relative "../../test_helper"

module NBA
  class BoxScoreTraditionalTeamMissingKeysTest < Minitest::Test
    cover BoxScoreTraditional

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

    def test_missing_fgm
      assert_missing_key_returns_nil("FGM", 6, :fgm)
    end

    def test_missing_fga
      assert_missing_key_returns_nil("FGA", 7, :fga)
    end

    def test_missing_fg_pct
      assert_missing_key_returns_nil("FG_PCT", 8, :fg_pct)
    end

    def test_missing_fg3m
      assert_missing_key_returns_nil("FG3M", 9, :fg3m)
    end

    def test_missing_fg3a
      assert_missing_key_returns_nil("FG3A", 10, :fg3a)
    end

    def test_missing_fg3_pct
      assert_missing_key_returns_nil("FG3_PCT", 11, :fg3_pct)
    end

    def test_missing_ftm
      assert_missing_key_returns_nil("FTM", 12, :ftm)
    end

    def test_missing_fta
      assert_missing_key_returns_nil("FTA", 13, :fta)
    end

    def test_missing_ft_pct
      assert_missing_key_returns_nil("FT_PCT", 14, :ft_pct)
    end

    def test_missing_oreb
      assert_missing_key_returns_nil("OREB", 15, :oreb)
    end

    def test_missing_dreb
      assert_missing_key_returns_nil("DREB", 16, :dreb)
    end

    def test_missing_reb
      assert_missing_key_returns_nil("REB", 17, :reb)
    end

    def test_missing_ast
      assert_missing_key_returns_nil("AST", 18, :ast)
    end

    def test_missing_stl
      assert_missing_key_returns_nil("STL", 19, :stl)
    end

    def test_missing_blk
      assert_missing_key_returns_nil("BLK", 20, :blk)
    end

    def test_missing_tov
      assert_missing_key_returns_nil("TO", 21, :tov)
    end

    def test_missing_pf
      assert_missing_key_returns_nil("PF", 22, :pf)
    end

    def test_missing_pts
      assert_missing_key_returns_nil("PTS", 23, :pts)
    end

    def test_missing_plus_minus
      assert_missing_key_returns_nil("PLUS_MINUS", 24, :plus_minus)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = team_headers.reject { |h| h == key }
      row = team_row[0...index] + team_row[(index + 1)..]
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)
      stat = BoxScoreTraditional.team_stats(game: "001").first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00", 42, 88, 0.477, 15, 40,
        0.375, 20, 25, 0.8, 10, 35, 45, 28, 8, 5, 12, 18, 119, 12]
    end
  end
end
