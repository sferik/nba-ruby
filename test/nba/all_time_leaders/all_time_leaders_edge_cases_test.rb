require_relative "../../test_helper"

module NBA
  class AllTimeLeadersEdgeCasesTest < Minitest::Test
    cover AllTimeLeaders

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = AllTimeLeaders.find(category: AllTimeLeaders::PTS, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /alltimeleadersgrids/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, AllTimeLeaders.find(category: AllTimeLeaders::PTS).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /alltimeleadersgrids/).to_return(body: {}.to_json)

      assert_equal 0, AllTimeLeaders.find(category: AllTimeLeaders::PTS).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "PTSLeaders", rowSet: [[1]]}]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      assert_equal 0, AllTimeLeaders.find(category: AllTimeLeaders::PTS).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "PTSLeaders", headers: %w[PLAYER_ID]}]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      assert_equal 0, AllTimeLeaders.find(category: AllTimeLeaders::PTS).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      assert_equal 0, AllTimeLeaders.find(category: AllTimeLeaders::PTS).size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "PTSLeaders", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      assert_equal 0, AllTimeLeaders.find(category: AllTimeLeaders::PTS).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "PTSLeaders", headers: %w[PLAYER_ID], rowSet: nil}]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      assert_equal 0, AllTimeLeaders.find(category: AllTimeLeaders::PTS).size
    end

    def test_returns_empty_when_category_invalid
      response = {resultSets: [{name: "PTSLeaders", headers: leader_headers, rowSet: [leader_row]}]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      assert_equal 0, AllTimeLeaders.find(category: "INVALID").size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PTSLeaders", headers: leader_headers, rowSet: [leader_row]}
      ]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      leaders = AllTimeLeaders.find(category: AllTimeLeaders::PTS)

      assert_equal 1, leaders.size
      assert_equal 2544, leaders.first.player_id
    end

    def test_finds_result_set_when_not_last
      wrong_row = [999_999, "Wrong Player", "N", 0]
      response = {resultSets: [
        {name: "PTSLeaders", headers: leader_headers, rowSet: [leader_row]},
        {name: "Other", headers: leader_headers, rowSet: [wrong_row]}
      ]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      leaders = AllTimeLeaders.find(category: AllTimeLeaders::PTS)

      assert_equal 1, leaders.size
      assert_equal "LeBron James", leaders.first.player_name
    end

    def test_handles_different_categories
      response = {resultSets: [{name: "REBLeaders", headers: reb_headers, rowSet: [reb_row]}]}
      stub_request(:get, /alltimeleadersgrids/).to_return(body: response.to_json)

      leaders = AllTimeLeaders.find(category: AllTimeLeaders::REB)

      assert_equal 1, leaders.size
      assert_equal "REB", leaders.first.category
    end

    private

    def leader_headers
      %w[PLAYER_ID PLAYER_NAME IS_ACTIVE_FLAG PTS]
    end

    def leader_row
      [2544, "LeBron James", "Y", 40_474]
    end

    def reb_headers
      %w[PLAYER_ID PLAYER_NAME IS_ACTIVE_FLAG REB]
    end

    def reb_row
      [2544, "LeBron James", "Y", 15_000]
    end
  end
end
