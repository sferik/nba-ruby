require_relative "../../test_helper"

module NBA
  class FranchiseHistoryParseHistoryTest < Minitest::Test
    cover FranchiseHistory

    def test_all_parses_start_year
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal 1946, franchise.start_year
    end

    def test_all_parses_end_year
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal 2024, franchise.end_year
    end

    def test_all_parses_years
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal 78, franchise.years
    end

    def test_all_parses_games
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal 5832, franchise.games
    end

    def test_all_parses_wins
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal 2980, franchise.wins
    end

    def test_all_parses_losses
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_equal 2852, franchise.losses
    end

    def test_all_parses_win_pct
      stub_franchise_history_request

      franchise = FranchiseHistory.all.first

      assert_in_delta 0.511, franchise.win_pct
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
