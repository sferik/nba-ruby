require_relative "common_team_years_edge_cases_helper"

module NBA
  class CommonTeamYearsNilResponseTest < Minitest::Test
    include CommonTeamYearsTestHelpers

    cover CommonTeamYears

    def test_all_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = CommonTeamYears.all(client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_all_returns_empty_when_no_result_sets
      stub_request(:get, /commonteamyears/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_result_sets_key_missing
      stub_request(:get, /commonteamyears/).to_return(body: {}.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "TeamYears", rowSet: [[1]]}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "TeamYears", headers: %w[TEAM_ID]}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_no_headers
      response = {resultSets: [{name: "TeamYears", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end

    def test_all_returns_empty_when_no_rows
      response = {resultSets: [{name: "TeamYears", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /commonteamyears/).to_return(body: response.to_json)

      assert_equal 0, CommonTeamYears.all.size
    end
  end
end
