require_relative "../../test_helper"

module NBA
  class TeamDetailsEdgeCasesTest < Minitest::Test
    cover TeamDetails

    def test_find_returns_nil_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamDetails.find(team: Team::GSW, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_find_returns_nil_when_no_result_sets
      stub_request(:get, /teamdetails/).to_return(body: {resultSets: nil}.to_json)

      assert_nil TeamDetails.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_result_sets_key_missing
      stub_request(:get, /teamdetails/).to_return(body: {}.to_json)

      assert_nil TeamDetails.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_headers_key_missing
      response = {resultSets: [{name: "TeamBackground", rowSet: [[1]]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_nil TeamDetails.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_row_set_key_missing
      response = {resultSets: [{name: "TeamBackground", headers: %w[TEAM_ID]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_nil TeamDetails.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_nil TeamDetails.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_no_headers
      response = {resultSets: [{name: "TeamBackground", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_nil TeamDetails.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_no_row
      response = {resultSets: [{name: "TeamBackground", headers: %w[TEAM_ID], rowSet: []}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_nil TeamDetails.find(team: Team::GSW)
    end

    def test_history_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamDetails.history(team: Team::GSW, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_history_returns_empty_when_no_result_sets
      stub_request(:get, /teamdetails/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, TeamDetails.history(team: Team::GSW).size
    end

    def test_history_returns_empty_when_no_headers
      response = {resultSets: [{name: "TeamHistory", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_equal 0, TeamDetails.history(team: Team::GSW).size
    end

    def test_history_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "TeamHistory", rowSet: [[1]]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_equal 0, TeamDetails.history(team: Team::GSW).size
    end

    def test_history_returns_empty_when_no_rows
      response = {resultSets: [{name: "TeamHistory", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_equal 0, TeamDetails.history(team: Team::GSW).size
    end

    def test_history_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "TeamHistory", headers: %w[TEAM_ID]}]}
      stub_request(:get, /teamdetails/).to_return(body: response.to_json)

      assert_equal 0, TeamDetails.history(team: Team::GSW).size
    end
  end
end
