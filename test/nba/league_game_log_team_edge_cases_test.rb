require_relative "../test_helper"

module NBA
  class LeagueGameLogTeamEdgeCasesTest < Minitest::Test
    cover LeagueGameLog

    def test_team_logs_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueGameLog.team_logs(season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_team_logs_returns_empty_when_no_rows
      response = {resultSets: [{name: "LeagueGameLog", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.team_logs(season: 2024).size
    end

    def test_team_logs_returns_empty_when_no_headers
      response = {resultSets: [{name: "LeagueGameLog", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.team_logs(season: 2024).size
    end

    def test_team_logs_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "LeagueGameLog", rowSet: [[1]]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.team_logs(season: 2024).size
    end

    def test_team_logs_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "LeagueGameLog", headers: %w[TEAM_ID]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.team_logs(season: 2024).size
    end

    def test_team_logs_returns_empty_when_no_result_sets
      stub_request(:get, /leaguegamelog/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueGameLog.team_logs(season: 2024).size
    end

    def test_team_logs_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.team_logs(season: 2024).size
    end
  end
end
