require_relative "../test_helper"

module NBA
  class LeagueDashPlayerShotLocationsMissingColumnNamesTest < Minitest::Test
    cover LeagueDashPlayerShotLocations

    def test_handles_missing_column_names_in_header_group
      response = {resultSets: [{name: "ShotLocations", headers: [{columnNames: nil}], rowSet: []}]}
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: response.to_json)

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_handles_empty_column_names_in_header_group
      response = {resultSets: [{name: "ShotLocations", headers: [{columnNames: []}], rowSet: []}]}
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: response.to_json)

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_handles_missing_column_names_key_in_header_group
      response = {resultSets: [{name: "ShotLocations", headers: [{}], rowSet: []}]}
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: response.to_json)

      result = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_uses_flat_map_to_flatten_nested_headers
      stub_request(:get, /leaguedashplayershotlocations/).to_return(body: nested_headers_response.to_json)

      stats = LeagueDashPlayerShotLocations.all(season: 2024)

      assert_equal 1, stats.first.player_id
      assert_equal "Test", stats.first.player_name
      assert_equal 100, stats.first.team_id
    end

    private

    def nested_headers_response
      {resultSets: [{name: "ShotLocations", headers: nested_headers, rowSet: [[1, "Test", 100, "TST", 25.0]]}]}
    end

    def nested_headers
      [{columnNames: %w[PLAYER_ID PLAYER_NAME]}, {columnNames: %w[TEAM_ID TEAM_ABBREVIATION AGE]}]
    end
  end
end
