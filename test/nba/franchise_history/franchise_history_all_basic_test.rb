require_relative "../../test_helper"

module NBA
  class FranchiseHistoryAllBasicTest < Minitest::Test
    cover FranchiseHistory

    def test_all_returns_collection
      stub_franchise_history_request

      assert_instance_of Collection, FranchiseHistory.all
    end

    def test_all_uses_default_league_id
      stub_franchise_history_request

      FranchiseHistory.all

      assert_requested :get, /franchisehistory.*LeagueID=00/
    end

    def test_all_accepts_custom_league_id
      stub_franchise_history_request

      FranchiseHistory.all(league: "10")

      assert_requested :get, /franchisehistory.*LeagueID=10/
    end

    def test_all_accepts_league_object
      stub_franchise_history_request
      league = League.new(id: "10", name: "WNBA")

      FranchiseHistory.all(league: league)

      assert_requested :get, /franchisehistory.*LeagueID=10/
    end

    private

    def stub_franchise_history_request
      stub_request(:get, /franchisehistory/).to_return(body: franchise_history_response.to_json)
    end

    def franchise_history_response
      {resultSets: [
        {name: "FranchiseHistory", headers: franchise_headers, rowSet: [franchise_row]},
        {name: "DefunctTeams", headers: franchise_headers, rowSet: []}
      ]}
    end

    def franchise_headers
      %w[LEAGUE_ID TEAM_ID TEAM_CITY TEAM_NAME START_YEAR END_YEAR YEARS GAMES WINS LOSSES
        WIN_PCT PO_APPEARANCES DIV_TITLES CONF_TITLES LEAGUE_TITLES]
    end

    def franchise_row
      ["00", Team::GSW, "Golden State", "Warriors", 1946, 2024, 78, 5832, 2980, 2852,
        0.511, 35, 12, 7, 7]
    end
  end
end
