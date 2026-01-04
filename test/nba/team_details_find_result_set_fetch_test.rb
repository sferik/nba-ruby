require_relative "../test_helper"

module NBA
  class TeamDetailsFindResultSetFetchTest < Minitest::Test
    cover TeamDetails

    def test_find_returns_nil_when_result_set_missing_name_key
      response = {resultSets: [{headers: detail_headers, rowSet: [detail_row]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_nil TeamDetails.find(team: Team::GSW)
    end

    def test_history_returns_empty_when_result_set_missing_name_key
      response = {resultSets: [{headers: history_headers, rowSet: [history_row]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_equal 0, TeamDetails.history(team: Team::GSW).size
    end

    private

    def detail_headers
      %w[TEAM_ID ABBREVIATION NICKNAME YEARFOUNDED CITY ARENA ARENACAPACITY OWNER
        GENERALMANAGER HEADCOACH DLEAGUEAFFILIATION]
    end

    def detail_row
      [Team::GSW, "GSW", "Warriors", 1946, "Golden State", "Chase Center", 18_064,
        "Joe Lacob", "Mike Dunleavy Jr.", "Steve Kerr", "Santa Cruz Warriors"]
    end

    def history_headers
      %w[TEAM_ID CITY NICKNAME SEASON_ID YEAR WINS LOSSES WIN_PCT CONF_RANK DIV_RANK
        PO_WINS PO_LOSSES CONF_COUNT DIV_COUNT NBA_FINALS_APPEARANCE]
    end

    def history_row
      [Team::GSW, "Golden State", "Warriors", "22024", 2024, 46, 36, 0.561, 10, 3,
        0, 0, 0, 0, "N/A"]
    end
  end
end
