require_relative "draft_combine_spot_shooting_edge_cases_helper"

module NBA
  class DraftCombineSpotShootingResultSetTest < Minitest::Test
    include DraftCombineSpotShootingEdgeCasesHelper

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
  end
end
