require_relative "../test_helper"
require_relative "team_game_logs_test_helper"

module NBA
  class TeamGameLogsEdgeCasesTest < Minitest::Test
    include TeamGameLogsTestHelper

    cover TeamGameLogs

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamGameLogs.all(season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /teamgamelogs/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, TeamGameLogs.all(season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /teamgamelogs/).to_return(body: {}.to_json)

      assert_equal 0, TeamGameLogs.all(season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "TeamGameLogs", rowSet: [[1]]}]}
      stub_request(:get, /teamgamelogs/).to_return(body: response.to_json)

      assert_equal 0, TeamGameLogs.all(season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "TeamGameLogs", headers: %w[TEAM_ID]}]}
      stub_request(:get, /teamgamelogs/).to_return(body: response.to_json)

      assert_equal 0, TeamGameLogs.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /teamgamelogs/).to_return(body: response.to_json)

      assert_equal 0, TeamGameLogs.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: stat_headers, rowSet: [stat_row]}]}
      stub_request(:get, /teamgamelogs/).to_return(body: response.to_json)

      assert_equal 0, TeamGameLogs.all(season: 2024).size
    end

    def test_skips_result_sets_with_missing_name_key
      response = {resultSets: [
        {headers: [], rowSet: []},
        {name: "TeamGameLogs", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /teamgamelogs/).to_return(body: response.to_json)

      stats = TeamGameLogs.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "TeamGameLogs", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /teamgamelogs/).to_return(body: response.to_json)

      assert_equal 0, TeamGameLogs.all(season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "TeamGameLogs", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /teamgamelogs/).to_return(body: response.to_json)

      assert_equal 0, TeamGameLogs.all(season: 2024).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamGameLogs", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /teamgamelogs/).to_return(body: response.to_json)

      stats = TeamGameLogs.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "TeamGameLogs", headers: stat_headers, rowSet: [stat_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /teamgamelogs/).to_return(body: response.to_json)

      stats = TeamGameLogs.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal "Warriors", stats.first.team_name
    end
  end
end
