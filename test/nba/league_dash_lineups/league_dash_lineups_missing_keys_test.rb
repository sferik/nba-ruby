require_relative "../../test_helper"

module NBA
  class LeagueDashLineupsMissingKeysTest < Minitest::Test
    cover LeagueDashLineups

    def test_handles_missing_group_set
      assert_missing_key_returns_nil("GROUP_SET", 0, :group_set)
    end

    def test_handles_missing_group_id
      assert_missing_key_returns_nil("GROUP_ID", 1, :group_id)
    end

    def test_handles_missing_group_name
      assert_missing_key_returns_nil("GROUP_NAME", 2, :group_name)
    end

    def test_handles_missing_team_id
      assert_missing_key_returns_nil("TEAM_ID", 3, :team_id)
    end

    def test_handles_missing_team_abbreviation
      assert_missing_key_returns_nil("TEAM_ABBREVIATION", 4, :team_abbreviation)
    end

    def test_handles_missing_gp
      assert_missing_key_returns_nil("GP", 5, :gp)
    end

    def test_handles_missing_w
      assert_missing_key_returns_nil("W", 6, :w)
    end

    def test_handles_missing_l
      assert_missing_key_returns_nil("L", 7, :l)
    end

    def test_handles_missing_w_pct
      assert_missing_key_returns_nil("W_PCT", 8, :w_pct)
    end

    def test_handles_missing_min
      assert_missing_key_returns_nil("MIN", 9, :min)
    end

    def test_handles_missing_fgm
      assert_missing_key_returns_nil("FGM", 10, :fgm)
    end

    def test_handles_missing_fga
      assert_missing_key_returns_nil("FGA", 11, :fga)
    end

    def test_handles_missing_fg_pct
      assert_missing_key_returns_nil("FG_PCT", 12, :fg_pct)
    end

    def test_handles_missing_fg3m
      assert_missing_key_returns_nil("FG3M", 13, :fg3m)
    end

    def test_handles_missing_fg3a
      assert_missing_key_returns_nil("FG3A", 14, :fg3a)
    end

    def test_handles_missing_fg3_pct
      assert_missing_key_returns_nil("FG3_PCT", 15, :fg3_pct)
    end

    def test_handles_missing_ftm
      assert_missing_key_returns_nil("FTM", 16, :ftm)
    end

    def test_handles_missing_fta
      assert_missing_key_returns_nil("FTA", 17, :fta)
    end

    def test_handles_missing_ft_pct
      assert_missing_key_returns_nil("FT_PCT", 18, :ft_pct)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "Lineups", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashlineups/).to_return(body: response.to_json)

      stat = LeagueDashLineups.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[GROUP_SET GROUP_ID GROUP_NAME TEAM_ID TEAM_ABBREVIATION GP W L W_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL
        BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def stat_row
      ["5 Man Lineups", "201939-203110", "S. Curry - K. Thompson", Team::GSW, "GSW", 45, 30, 15, 0.667, 245.5,
        8.5, 17.2, 0.494, 3.2, 8.5, 0.376, 3.1, 3.8, 0.816, 1.8, 6.2, 8.0, 5.5, 2.1, 1.5,
        0.8, 0.5, 2.3, 3.1, 23.3, 8.5]
    end
  end
end
