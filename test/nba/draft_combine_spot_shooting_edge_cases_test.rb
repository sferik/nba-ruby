require_relative "../test_helper"

module NBA
  class DraftCombineSpotShootingEdgeCasesTest < Minitest::Test
    cover DraftCombineSpotShooting

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = DraftCombineSpotShooting.all(season: 2019, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /draftcombinespotshooting/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, DraftCombineSpotShooting.all(season: 2019).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /draftcombinespotshooting/).to_return(body: {}.to_json)

      assert_equal 0, DraftCombineSpotShooting.all(season: 2019).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "Results", rowSet: [[1]]}]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineSpotShooting.all(season: 2019).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "Results", headers: %w[PLAYER_ID]}]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineSpotShooting.all(season: 2019).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineSpotShooting.all(season: 2019).size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "Results", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineSpotShooting.all(season: 2019).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "Results", headers: %w[PLAYER_ID], rowSet: nil}]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineSpotShooting.all(season: 2019).size
    end

    def test_returns_empty_when_result_set_name_missing
      response = {resultSets: [{headers: %w[PLAYER_ID PLAYER_NAME], rowSet: [[1, "Test"]]}]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineSpotShooting.all(season: 2019).size
    end
  end

  class DraftCombineSpotShootingResultSetTest < Minitest::Test
    cover DraftCombineSpotShooting

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "Results", headers: headers, rowSet: [row]}
      ]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      results = DraftCombineSpotShooting.all(season: 2019)

      assert_equal 1, results.size
      assert_equal 1_630_162, results.first.player_id
    end

    def test_finds_result_set_when_not_last
      wrong_row = [999_999, "Wrong Player", "Wrong", "Player", "G"]
      response = {resultSets: [
        {name: "Results", headers: headers, rowSet: [row]},
        {name: "Other", headers: headers, rowSet: [wrong_row]}
      ]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      results = DraftCombineSpotShooting.all(season: 2019)

      assert_equal 1, results.size
      assert_equal "Victor Wembanyama", results.first.player_name
    end

    def test_handles_multiple_results
      rows = [row, [1_630_163, "Brandon Miller", "Brandon", "Miller", "F"]]
      response = {resultSets: [{name: "Results", headers: headers, rowSet: rows}]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      results = DraftCombineSpotShooting.all(season: 2019)

      assert_equal 2, results.size
      assert_equal 1_630_162, results.first.player_id
      assert_equal 1_630_163, results.last.player_id
    end

    def test_handles_missing_optional_fields
      response = {resultSets: [{name: "Results", headers: headers, rowSet: [row]}]}
      stub_request(:get, /draftcombinespotshooting/).to_return(body: response.to_json)

      result = DraftCombineSpotShooting.all(season: 2019).first

      assert_equal 1_630_162, result.player_id
      assert_nil result.fifteen_corner_left_made
    end

    private

    def headers
      %w[PLAYER_ID PLAYER_NAME FIRST_NAME LAST_NAME POSITION]
    end

    def row
      [1_630_162, "Victor Wembanyama", "Victor", "Wembanyama", "C"]
    end
  end
end
