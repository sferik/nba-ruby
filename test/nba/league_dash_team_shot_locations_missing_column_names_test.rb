require_relative "../test_helper"

module NBA
  class LeagueDashTeamShotLocationsMissingColumnNamesTest < Minitest::Test
    cover LeagueDashTeamShotLocations

    def test_handles_missing_column_names_in_header_group
      response = {resultSets: [{name: "ShotLocations", headers: [{columnNames: nil}], rowSet: []}]}
      stub_request(:get, /leaguedashteamshotlocations/).to_return(body: response.to_json)

      result = LeagueDashTeamShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_handles_empty_column_names_in_header_group
      response = {resultSets: [{name: "ShotLocations", headers: [{columnNames: []}], rowSet: []}]}
      stub_request(:get, /leaguedashteamshotlocations/).to_return(body: response.to_json)

      result = LeagueDashTeamShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_handles_missing_column_names_key_in_header_group
      response = {resultSets: [{name: "ShotLocations", headers: [{}], rowSet: []}]}
      stub_request(:get, /leaguedashteamshotlocations/).to_return(body: response.to_json)

      result = LeagueDashTeamShotLocations.all(season: 2024)

      assert_empty result
    end

    def test_uses_flat_map_to_flatten_nested_headers
      stub_request(:get, /leaguedashteamshotlocations/).to_return(body: nested_headers_response.to_json)

      stats = LeagueDashTeamShotLocations.all(season: 2024)

      assert_equal Team::GSW, stats.first.team_id
      assert_equal "Golden State Warriors", stats.first.team_name
    end

    private

    def nested_headers_response
      {resultSets: [{name: "ShotLocations", headers: nested_headers, rowSet: [[Team::GSW, "Golden State Warriors"]]}]}
    end

    def nested_headers
      [{columnNames: %w[TEAM_ID]}, {columnNames: %w[TEAM_NAME]}]
    end
  end
end
