require_relative "../../test_helper"

module NBA
  class LeagueDashTeamClutchMissingShootingKeysTest < Minitest::Test
    cover LeagueDashTeamClutch

    def test_handles_missing_fgm
      assert_missing_key_returns_nil("FGM", 7, :fgm)
    end

    def test_handles_missing_fga
      assert_missing_key_returns_nil("FGA", 8, :fga)
    end

    def test_handles_missing_fg_pct
      assert_missing_key_returns_nil("FG_PCT", 9, :fg_pct)
    end

    def test_handles_missing_fg3m
      assert_missing_key_returns_nil("FG3M", 10, :fg3m)
    end

    def test_handles_missing_fg3a
      assert_missing_key_returns_nil("FG3A", 11, :fg3a)
    end

    def test_handles_missing_fg3_pct
      assert_missing_key_returns_nil("FG3_PCT", 12, :fg3_pct)
    end

    def test_handles_missing_ftm
      assert_missing_key_returns_nil("FTM", 13, :ftm)
    end

    def test_handles_missing_fta
      assert_missing_key_returns_nil("FTA", 14, :fta)
    end

    def test_handles_missing_ft_pct
      assert_missing_key_returns_nil("FT_PCT", 15, :ft_pct)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "LeagueDashTeamClutch", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguedashteamclutch/).to_return(body: response.to_json)

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK PF PTS PLUS_MINUS]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", 82, 46, 36, 0.561, 5.0, 3.2, 7.5, 0.427, 1.2, 3.5, 0.343,
        2.0, 2.5, 0.800, 0.8, 2.2, 3.0, 1.8, 1.2, 0.6, 0.3, 1.5, 9.6, 0.8]
    end
  end
end
