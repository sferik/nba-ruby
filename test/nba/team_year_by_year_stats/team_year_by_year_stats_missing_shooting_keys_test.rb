require_relative "../../test_helper"

module NBA
  class TeamYearByYearStatsMissingShootingKeysTest < Minitest::Test
    cover TeamYearByYearStats

    def test_handles_missing_fgm
      assert_missing_key_returns_nil("FGM", 13, :fgm)
    end

    def test_handles_missing_fga
      assert_missing_key_returns_nil("FGA", 14, :fga)
    end

    def test_handles_missing_fg_pct
      assert_missing_key_returns_nil("FG_PCT", 15, :fg_pct)
    end

    def test_handles_missing_fg3m
      assert_missing_key_returns_nil("FG3M", 16, :fg3m)
    end

    def test_handles_missing_fg3a
      assert_missing_key_returns_nil("FG3A", 17, :fg3a)
    end

    def test_handles_missing_fg3_pct
      assert_missing_key_returns_nil("FG3_PCT", 18, :fg3_pct)
    end

    def test_handles_missing_ftm
      assert_missing_key_returns_nil("FTM", 19, :ftm)
    end

    def test_handles_missing_fta
      assert_missing_key_returns_nil("FTA", 20, :fta)
    end

    def test_handles_missing_ft_pct
      assert_missing_key_returns_nil("FT_PCT", 21, :ft_pct)
    end

    private

    def assert_missing_key_returns_nil(key, index, attribute)
      headers = stat_headers.reject { |h| h == key }
      row = stat_row[0...index] + stat_row[(index + 1)..]
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /teamyearbyyearstats/).to_return(body: response.to_json)

      stat = TeamYearByYearStats.find(team: Team::GSW).first

      assert_nil stat.send(attribute), "Expected #{attribute} to be nil when #{key} is missing"
    end

    def stat_headers
      %w[TEAM_ID TEAM_CITY TEAM_NAME YEAR GP WINS LOSSES WIN_PCT CONF_RANK DIV_RANK
        PO_WINS PO_LOSSES NBA_FINALS_APPEARANCE FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST PF STL TOV BLK PTS PTS_RANK]
    end

    def stat_row
      [Team::GSW, "Golden State", "Warriors", "2024-25", 82, 46, 36, 0.561, 10, 3,
        0, 0, "N/A", 43.2, 91.5, 0.472, 14.8, 40.2, 0.368, 17.5, 22.1, 0.792,
        10.5, 33.8, 44.3, 28.1, 19.5, 7.8, 14.2, 5.2, 118.7, 5]
    end
  end
end
