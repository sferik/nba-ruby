require_relative "../../test_helper"

module NBA
  class TeamYearByYearStatsMissingCountingKeysTest < Minitest::Test
    cover TeamYearByYearStats

    def test_handles_missing_oreb
      assert_missing_key_returns_nil("OREB", 22, :oreb)
    end

    def test_handles_missing_dreb
      assert_missing_key_returns_nil("DREB", 23, :dreb)
    end

    def test_handles_missing_reb
      assert_missing_key_returns_nil("REB", 24, :reb)
    end

    def test_handles_missing_ast
      assert_missing_key_returns_nil("AST", 25, :ast)
    end

    def test_handles_missing_pf
      assert_missing_key_returns_nil("PF", 26, :pf)
    end

    def test_handles_missing_stl
      assert_missing_key_returns_nil("STL", 27, :stl)
    end

    def test_handles_missing_tov
      assert_missing_key_returns_nil("TOV", 28, :tov)
    end

    def test_handles_missing_blk
      assert_missing_key_returns_nil("BLK", 29, :blk)
    end

    def test_handles_missing_pts
      assert_missing_key_returns_nil("PTS", 30, :pts)
    end

    def test_handles_missing_pts_rank
      assert_missing_key_returns_nil("PTS_RANK", 31, :pts_rank)
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
