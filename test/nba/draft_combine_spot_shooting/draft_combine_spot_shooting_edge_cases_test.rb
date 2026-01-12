require_relative "../../test_helper"

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
end
