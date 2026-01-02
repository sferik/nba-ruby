require_relative "../test_helper"

module NBA
  class FranchiseHistoryParseIdentityTest < Minitest::Test
    cover FranchiseHistory

    def test_all_parses_league_id
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal "00", franchise.league_id
    end

    def test_all_parses_team_id
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal Team::GSW, franchise.team_id
    end

    def test_all_parses_team_city
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal "Golden State", franchise.team_city
    end

    def test_all_parses_team_name
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal "Warriors", franchise.team_name
    end

    private

    def stub_franchise_history_request
      stub_request(:get, /franchisehistory/).to_return(body: franchise_history_response.to_json)
    end

    def franchise_history_response
      {resultSets: [
        {name: "FranchiseHistory", headers: franchise_headers, rowSet: [franchise_row]}
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
