require_relative "../../test_helper"

module NBA
  class LeagueDashTeamClutchEdgeCasesTest < Minitest::Test
    cover LeagueDashTeamClutch

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueDashTeamClutch.all(season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /leaguedashteamclutch/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueDashTeamClutch.all(season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /leaguedashteamclutch/).to_return(body: {}.to_json)

      assert_equal 0, LeagueDashTeamClutch.all(season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "LeagueDashTeamClutch", rowSet: [[1]]}]}
      stub_request(:get, /leaguedashteamclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamClutch.all(season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "LeagueDashTeamClutch", headers: %w[TEAM_ID]}]}
      stub_request(:get, /leaguedashteamclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamClutch.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /leaguedashteamclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamClutch.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: stat_headers, rowSet: [stat_row]}]}
      stub_request(:get, /leaguedashteamclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamClutch.all(season: 2024).size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "LeagueDashTeamClutch", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /leaguedashteamclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamClutch.all(season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "LeagueDashTeamClutch", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /leaguedashteamclutch/).to_return(body: response.to_json)

      assert_equal 0, LeagueDashTeamClutch.all(season: 2024).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "LeagueDashTeamClutch", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /leaguedashteamclutch/).to_return(body: response.to_json)

      stats = LeagueDashTeamClutch.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "LeagueDashTeamClutch", headers: stat_headers, rowSet: [stat_row]},
        {name: "Other", headers: %w[WRONG], rowSet: [["wrong_data"]]}
      ]}
      stub_request(:get, /leaguedashteamclutch/).to_return(body: response.to_json)

      stats = LeagueDashTeamClutch.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal "Golden State Warriors", stats.first.team_name
    end

    private

    def stat_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK PF PTS PLUS_MINUS]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", 82, 46, 36, 0.561, 5.0, 3.2, 7.5, 0.427, 1.2, 3.5, 0.343,
        2.0, 2.5, 0.800, 0.8, 2.2, 3.0, 1.8, 1.2, 0.6, 0.3, 1.5, 9.6, 0.8]
    end
  end
end
