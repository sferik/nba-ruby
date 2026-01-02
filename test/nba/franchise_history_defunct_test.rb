require_relative "../test_helper"

module NBA
  class FranchiseHistoryDefunctTest < Minitest::Test
    cover FranchiseHistory

    def test_defunct_returns_collection
      stub_franchise_history_request

      assert_instance_of Collection, FranchiseHistory.defunct
    end

    def test_defunct_uses_defunct_teams_result_set
      stub_franchise_history_request

      franchises = FranchiseHistory.defunct

      assert_equal 1, franchises.size
      assert_equal "Seattle", franchises.first.team_city
    end

    def test_defunct_uses_default_league_id
      stub_franchise_history_request

      FranchiseHistory.defunct

      assert_requested :get, /franchisehistory.*LeagueID=00/
    end

    def test_defunct_accepts_league_object
      stub_franchise_history_request
      league = League.new(id: "10", name: "WNBA")

      FranchiseHistory.defunct(league: league)

      assert_requested :get, /franchisehistory.*LeagueID=10/
    end

    private

    def stub_franchise_history_request
      stub_request(:get, /franchisehistory/).to_return(body: franchise_history_response.to_json)
    end

    def franchise_history_response
      {resultSets: [
        {name: "FranchiseHistory", headers: franchise_headers, rowSet: []},
        {name: "DefunctTeams", headers: franchise_headers, rowSet: [defunct_row]}
      ]}
    end

    def franchise_headers
      %w[LEAGUE_ID TEAM_ID TEAM_CITY TEAM_NAME START_YEAR END_YEAR YEARS GAMES WINS LOSSES
        WIN_PCT PO_APPEARANCES DIV_TITLES CONF_TITLES LEAGUE_TITLES]
    end

    def defunct_row
      ["00", 1_610_610_031, "Seattle", "SuperSonics", 1967, 2008, 41, 3291, 1745, 1546, 0.530, 22, 6, 3, 1]
    end
  end
end
