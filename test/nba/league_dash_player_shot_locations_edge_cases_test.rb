require_relative "../test_helper"

module NBA
  class LeagueDashPlayerShotLocationsEdgeCasesTest < Minitest::Test
    cover LeagueDashPlayerShotLocations

    def test_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueDashPlayerShotLocations.all(season: 2024, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_handles_empty_response
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: "")

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_handles_missing_result_sets
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: {}.to_json)

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_handles_empty_result_sets
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: {resultSets: []}.to_json)

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_handles_missing_shot_locations_result_set
      response = {resultSets: [{name: "OtherResultSet", headers: [], rowSet: []}]}
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: response.to_json)

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_finds_shot_locations_among_multiple_result_sets
      response = {resultSets: [
        {name: "OtherResultSet", headers: [{columnNames: ["OTHER"]}], rowSet: [["other"]]},
        {name: "ShotLocations", headers: [{columnNames: %w[PLAYER_ID]}], rowSet: [[201_939]]}
      ]}
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: response.to_json)

      stats = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_equal 201_939, stats.first.player_id
    end

    def test_handles_missing_headers
      response = {resultSets: [{name: "ShotLocations", rowSet: [[1, "Test"]]}]}
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: response.to_json)

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_handles_missing_row_set
      response = {resultSets: [{name: "ShotLocations", headers: [{columnNames: %w[PLAYER_ID]}]}]}
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: response.to_json)

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_handles_result_set_with_missing_name
      response = {resultSets: [{headers: [{columnNames: %w[PLAYER_ID]}], rowSet: [[1]]}]}
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: response.to_json)

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_empty result
    end
  end
end
