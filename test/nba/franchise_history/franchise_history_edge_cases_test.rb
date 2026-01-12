require_relative "../../test_helper"

module NBA
  class FranchiseHistoryEdgeCasesTest < Minitest::Test
    cover FranchiseHistory

    def test_all_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, FranchiseHistory.all(client: mock_client).size
      mock_client.verify
    end

    def test_all_returns_empty_collection_when_no_result_sets
      stub_request(:get, /franchisehistory/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, FranchiseHistory.all.size
    end

    def test_all_returns_empty_collection_when_result_sets_key_missing
      stub_request(:get, /franchisehistory/).to_return(body: {}.to_json)

      assert_equal 0, FranchiseHistory.all.size
    end

    def test_all_returns_empty_collection_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      assert_equal 0, FranchiseHistory.all.size
    end

    def test_all_returns_empty_collection_when_no_headers
      response = {resultSets: [{name: "FranchiseHistory", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      assert_equal 0, FranchiseHistory.all.size
    end

    def test_all_returns_empty_collection_when_headers_key_missing
      response = {resultSets: [{name: "FranchiseHistory", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      assert_equal 0, FranchiseHistory.all.size
    end

    def test_all_returns_empty_collection_when_no_rows
      response = {resultSets: [{name: "FranchiseHistory", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      assert_equal 0, FranchiseHistory.all.size
    end

    def test_all_returns_empty_collection_when_rowset_key_missing
      response = {resultSets: [{name: "FranchiseHistory", headers: %w[TEAM_ID]}]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      assert_equal 0, FranchiseHistory.all.size
    end

    def test_all_finds_result_set_when_not_first
      other_set = {name: "DefunctTeams", headers: %w[TEAM_ID TEAM_CITY], rowSet: [[123, "Seattle"]]}
      correct_set = {name: "FranchiseHistory", headers: %w[TEAM_ID TEAM_CITY], rowSet: [[Team::GSW, "Golden State"]]}
      response = {resultSets: [other_set, correct_set]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      franchise = FranchiseHistory.all.first

      assert_equal Team::GSW, franchise.team_id
      assert_equal "Golden State", franchise.team_city
    end

    def test_all_finds_correct_result_set_by_name
      correct_set = {name: "FranchiseHistory", headers: %w[TEAM_ID TEAM_CITY], rowSet: [[Team::GSW, "Golden State"]]}
      other_set = {name: "DefunctTeams", headers: %w[TEAM_ID TEAM_CITY], rowSet: [[123, "Seattle"]]}
      response = {resultSets: [correct_set, other_set]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      franchise = FranchiseHistory.all.first

      assert_equal Team::GSW, franchise.team_id
      assert_equal "Golden State", franchise.team_city
    end

    def test_all_handles_missing_team_id_header
      response = {resultSets: [{name: "FranchiseHistory", headers: %w[TEAM_CITY], rowSet: [["Golden State"]]}]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      franchise = FranchiseHistory.all.first

      assert_nil franchise.team_id
      assert_equal "Golden State", franchise.team_city
    end

    def test_all_handles_missing_team_id
      response = {resultSets: [{name: "FranchiseHistory", headers: %w[TEAM_CITY], rowSet: [["Golden State"]]}]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      franchise = FranchiseHistory.all.first

      assert_nil franchise.team_id
      assert_equal "Golden State", franchise.team_city
    end

    def test_all_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [["wrong"]]}
      franchise_set = {name: "FranchiseHistory", headers: %w[TEAM_ID TEAM_CITY], rowSet: [[Team::GSW, "Golden State"]]}
      response = {resultSets: [unnamed_set, franchise_set]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      franchise = FranchiseHistory.all.first

      assert_equal Team::GSW, franchise.team_id
      assert_equal "Golden State", franchise.team_city
    end

    def test_all_handles_missing_team_city_header
      response = {resultSets: [{name: "FranchiseHistory", headers: %w[TEAM_ID TEAM_NAME], rowSet: [[Team::GSW, "Warriors"]]}]}
      stub_request(:get, /franchisehistory/).to_return(body: response.to_json)

      franchise = FranchiseHistory.all.first

      assert_equal Team::GSW, franchise.team_id
      assert_nil franchise.team_city
      assert_equal "Warriors", franchise.team_name
    end
  end
end
