require_relative "../../test_helper"

module NBA
  class TeamDetailsFindFirstRowTest < Minitest::Test
    cover TeamDetails

    def test_find_returns_first_row_when_multiple_rows_exist
      stub_team_details_request_with_multiple_rows

      detail = TeamDetails.find(team: Team::GSW)

      # Should return the first row (Warriors), not the second row (Lakers)
      assert_equal Team::GSW, detail.team_id
      assert_equal "Warriors", detail.nickname
    end

    private

    def stub_team_details_request_with_multiple_rows
      response = {resultSets: [
        {name: "TeamBackground", headers: detail_headers, rowSet: [gsw_row, lal_row]},
        {name: "TeamHistory", headers: [], rowSet: []}
      ]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)
    end

    def detail_headers
      %w[TEAM_ID ABBREVIATION NICKNAME YEARFOUNDED CITY ARENA ARENACAPACITY OWNER
        GENERALMANAGER HEADCOACH DLEAGUEAFFILIATION]
    end

    def gsw_row
      [Team::GSW, "GSW", "Warriors", 1946, "Golden State", "Chase Center", 18_064,
        "Joe Lacob", "Mike Dunleavy Jr.", "Steve Kerr", "Santa Cruz Warriors"]
    end

    def lal_row
      [Team::LAL, "LAL", "Lakers", 1947, "Los Angeles", "Crypto.com Arena", 19_060,
        "Jeanie Buss", "Rob Pelinka", "JJ Redick", "South Bay Lakers"]
    end
  end
end
