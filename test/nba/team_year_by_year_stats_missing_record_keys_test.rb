require_relative "../test_helper"

module NBA
  class TeamYearByYearStatsMissingRecordKeysTest < Minitest::Test
    cover TeamYearByYearStats

    def test_handles_missing_wins
      assert_missing_key_returns_nil("WINS", 5, :wins)
    end

    def test_handles_missing_losses
      assert_missing_key_returns_nil("LOSSES", 6, :losses)
    end

    def test_handles_missing_win_pct
      assert_missing_key_returns_nil("WIN_PCT", 7, :win_pct)
    end

    def test_handles_missing_conf_rank
      assert_missing_key_returns_nil("CONF_RANK", 8, :conf_rank)
    end

    def test_handles_missing_div_rank
      assert_missing_key_returns_nil("DIV_RANK", 9, :div_rank)
    end

    def test_handles_missing_po_wins
      assert_missing_key_returns_nil("PO_WINS", 10, :po_wins)
    end

    def test_handles_missing_po_losses
      assert_missing_key_returns_nil("PO_LOSSES", 11, :po_losses)
    end

    def test_handles_missing_nba_finals_appearance
      assert_missing_key_returns_nil("NBA_FINALS_APPEARANCE", 12, :nba_finals_appearance)
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
