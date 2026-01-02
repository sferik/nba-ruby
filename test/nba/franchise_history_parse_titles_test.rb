require_relative "../test_helper"

module NBA
  class FranchiseHistoryParseTitlesTest < Minitest::Test
    cover FranchiseHistory

    def test_all_parses_playoff_appearances
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal 35, franchise.po_appearances
    end

    def test_all_parses_division_titles
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal 12, franchise.div_titles
    end

    def test_all_parses_conference_titles
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal 7, franchise.conf_titles
    end

    def test_all_parses_league_titles
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal 7, franchise.league_titles
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
