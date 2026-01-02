require_relative "../test_helper"

module NBA
  class LeagueDashTeamStatsEdgeCasesTest < Minitest::Test
    cover LeagueDashTeamStats

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueDashTeamStats.all(season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /leaguedashteamstats/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueDashTeamStats.all(season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /leaguedashteamstats/).to_return(body: {}.to_json)

      assert_equal 0, LeagueDashTeamStats.all(season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "LeagueDashTeamStats", rowSet: [[1]]}]}
      stub_request(:get, /leaguedashteamstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamStats.all(season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "LeagueDashTeamStats", headers: %w[TEAM_ID]}]}
      stub_request(:get, /leaguedashteamstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamStats.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /leaguedashteamstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamStats.all(season: 2024).size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "LeagueDashTeamStats", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /leaguedashteamstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamStats.all(season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "LeagueDashTeamStats", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /leaguedashteamstats/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamStats.all(season: 2024).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "LeagueDashTeamStats", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /leaguedashteamstats/).to_return(body: response.to_json)

      stats = LeagueDashTeamStats.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "LeagueDashTeamStats", headers: stat_headers, rowSet: [stat_row]},
        {name: "Other", headers: %w[WRONG], rowSet: [["wrong_data"]]}
      ]}
      stub_request(:get, /leaguedashteamstats/).to_return(body: response.to_json)

      stats = LeagueDashTeamStats.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal "Golden State Warriors", stats.first.team_name
    end

    private

    def stat_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS GP_RANK W_RANK PTS_RANK]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", 82, 53, 29, 0.646, 240.0, 42.3, 90.5, 0.467, 13.7, 38.2, 0.359,
        17.5, 22.3, 0.785, 10.2, 34.5, 44.7, 27.8, 13.2, 7.5, 5.2, 4.8, 18.5, 19.2, 115.8, 5.2, 1, 3, 5]
    end
  end
end
