require_relative "../test_helper"

module NBA
  class LeagueDashPtStatsEdgeCasesTest < Minitest::Test
    cover LeagueDashPtStats

    def test_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueDashPtStats.all(season: 2024, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_returns_empty_collection_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      result = LeagueDashPtStats.all(season: 2024, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_returns_empty_collection_when_result_sets_missing
      stub_request(:get, /leaguedashptstats/).to_return(body: {}.to_json)

      assert_empty LeagueDashPtStats.all(season: 2024)
    end

    def test_returns_empty_collection_when_result_set_not_found
      response = {resultSets: [{name: "OtherResultSet", headers: %w[PLAYER_ID], rowSet: [[999]]}]}
      stub_request(:get, /leaguedashptstats/).to_return(body: response.to_json)

      assert_empty LeagueDashPtStats.all(season: 2024)
    end

    def test_ignores_result_set_with_wrong_name
      other_set = {name: "OtherResultSet", headers: %w[PLAYER_ID], rowSet: [[999]]}
      correct_set = {name: "LeagueDashPtStats", headers: %w[PLAYER_ID], rowSet: [[201_939]]}
      response = {resultSets: [other_set, correct_set]}
      stub_request(:get, /leaguedashptstats/).to_return(body: response.to_json)

      result = LeagueDashPtStats.all(season: 2024)

      assert_equal 201_939, result.first.player_id
    end

    def test_returns_empty_collection_when_headers_missing
      response = {resultSets: [{name: "LeagueDashPtStats", rowSet: [[201_939]]}]}
      stub_request(:get, /leaguedashptstats/).to_return(body: response.to_json)

      assert_empty LeagueDashPtStats.all(season: 2024)
    end

    def test_returns_empty_collection_when_row_set_missing
      response = {resultSets: [{name: "LeagueDashPtStats", headers: %w[PLAYER_ID]}]}
      stub_request(:get, /leaguedashptstats/).to_return(body: response.to_json)

      assert_empty LeagueDashPtStats.all(season: 2024)
    end

    def test_returns_empty_collection_when_name_missing_from_result_set
      response = {resultSets: [{headers: %w[PLAYER_ID], rowSet: [[201_939]]}]}
      stub_request(:get, /leaguedashptstats/).to_return(body: response.to_json)

      assert_empty LeagueDashPtStats.all(season: 2024)
    end
  end
end
