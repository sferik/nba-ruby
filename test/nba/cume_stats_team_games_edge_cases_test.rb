require_relative "../test_helper"

module NBA
  class CumeStatsTeamGamesEdgeCasesTest < Minitest::Test
    cover CumeStatsTeamGames

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /cumestatsteamgames/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /cumestatsteamgames/).to_return(body: {}.to_json)

      assert_equal 0, CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "CumeStatsTeamGames", rowSet: [[1]]}]}
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "CumeStatsTeamGames", headers: %w[MATCHUP]}]}
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "CumeStatsTeamGames", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "CumeStatsTeamGames", headers: %w[MATCHUP], rowSet: nil}]}
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "CumeStatsTeamGames", headers: basic_headers, rowSet: [basic_row]}
      ]}
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      results = CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_equal 1, results.size
      assert_equal 22_300_001, results.first.game_id
    end

    def test_finds_result_set_when_not_last
      wrong_row = ["Wrong @ Matchup", 999_999]
      response = {resultSets: [
        {name: "CumeStatsTeamGames", headers: basic_headers, rowSet: [basic_row]},
        {name: "Other", headers: basic_headers, rowSet: [wrong_row]}
      ]}
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      results = CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_equal 1, results.size
      assert_equal "LAL @ DEN", results.first.matchup
    end

    def test_handles_multiple_results
      stub_request(:get, /cumestatsteamgames/).to_return(body: multi_result_response.to_json)

      results = CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023)

      assert_equal 2, results.size
      assert_equal 22_300_001, results.first.game_id
      assert_equal 22_300_002, results.last.game_id
    end

    def test_returns_empty_when_result_set_name_missing
      response = {resultSets: [{headers: basic_headers, rowSet: [basic_row]}]}
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      assert_equal 0, CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).size
    end

    private

    def basic_headers
      %w[MATCHUP GAME_ID]
    end

    def basic_row
      ["LAL @ DEN", 22_300_001]
    end

    def multi_result_response
      rows = [
        ["LAL @ DEN", 22_300_001],
        ["LAL vs GSW", 22_300_002]
      ]
      {resultSets: [{name: "CumeStatsTeamGames", headers: basic_headers, rowSet: rows}]}
    end
  end
end
