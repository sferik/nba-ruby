require_relative "../test_helper"

module NBA
  class FranchiseLeadersEdgeCasesTest < Minitest::Test
    cover FranchiseLeaders

    def test_find_returns_nil_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = FranchiseLeaders.find(team: Team::GSW, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_find_returns_nil_when_no_result_sets
      stub_request(:get, /franchiseleaders/).to_return(body: {resultSets: nil}.to_json)

      assert_nil FranchiseLeaders.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_result_sets_key_missing
      stub_request(:get, /franchiseleaders/).to_return(body: {}.to_json)

      assert_nil FranchiseLeaders.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

      assert_nil FranchiseLeaders.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_no_headers
      response = {resultSets: [{name: "FranchiseLeaders", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

      assert_nil FranchiseLeaders.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_headers_key_missing
      response = {resultSets: [{name: "FranchiseLeaders", rowSet: [[1]]}]}
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

      assert_nil FranchiseLeaders.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_no_row
      response = {resultSets: [{name: "FranchiseLeaders", headers: %w[TEAM_ID], rowSet: []}]}
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

      assert_nil FranchiseLeaders.find(team: Team::GSW)
    end

    def test_find_returns_nil_when_row_set_key_missing
      response = {resultSets: [{name: "FranchiseLeaders", headers: %w[TEAM_ID]}]}
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

      assert_nil FranchiseLeaders.find(team: Team::GSW)
    end

    def test_find_uses_first_row_when_multiple_rows_present
      response = {resultSets: [{name: "FranchiseLeaders", headers: all_headers, rowSet: [
        full_row,
        [Team::LAL, 1, "Player", 100, 2, "Other", 50, 3, "Third", 75, 4, "Fourth", 25, 5, "Fifth", 30]
      ]}]}
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

      leader = FranchiseLeaders.find(team: Team::GSW)

      assert_equal Team::GSW, leader.team_id
    end

    def test_find_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [["wrong"]]}
      correct_set = {name: "FranchiseLeaders", headers: all_headers, rowSet: [full_row]}
      response = {resultSets: [unnamed_set, correct_set]}
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

      leader = FranchiseLeaders.find(team: Team::GSW)

      assert_equal Team::GSW, leader.team_id
    end

    def test_find_finds_result_set_when_not_first
      other_set = {name: "Other", headers: %w[TEAM_ID], rowSet: [[123]]}
      correct_set = {name: "FranchiseLeaders", headers: all_headers, rowSet: [full_row]}
      response = {resultSets: [other_set, correct_set]}
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

      leader = FranchiseLeaders.find(team: Team::GSW)

      assert_equal Team::GSW, leader.team_id
    end

    def test_find_uses_first_matching_result_set
      first_match = {name: "FranchiseLeaders", headers: all_headers, rowSet: [full_row]}
      second_match = {name: "FranchiseLeaders", headers: all_headers, rowSet: [[Team::LAL, 1, "Player", 100, 2, "Other", 50, 3, "Third", 75, 4, "Fourth", 25, 5, "Fifth", 30]]}
      response = {resultSets: [first_match, second_match]}
      stub_request(:get, /franchiseleaders/).to_return(body: response.to_json)

      leader = FranchiseLeaders.find(team: Team::GSW)

      assert_equal Team::GSW, leader.team_id
    end

    private

    def all_headers
      %w[TEAM_ID PTS_PERSON_ID PTS_PLAYER PTS AST_PERSON_ID AST_PLAYER AST
        REB_PERSON_ID REB_PLAYER REB BLK_PERSON_ID BLK_PLAYER BLK
        STL_PERSON_ID STL_PLAYER STL]
    end

    def full_row
      [Team::GSW, 201_939, "Stephen Curry", 23_668, 201_939, "Stephen Curry", 5845,
        600_015, "Nate Thurmond", 12_771, 2442, "Manute Bol", 2086,
        959, "Chris Mullin", 1360]
    end
  end
end
