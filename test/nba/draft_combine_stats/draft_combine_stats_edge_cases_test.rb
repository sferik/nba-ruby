require_relative "../../test_helper"

module NBA
  class DraftCombineStatsEdgeCasesTest < Minitest::Test
    cover DraftCombineStats

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = DraftCombineStats.all(season: 2019, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /draftcombinestats/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, DraftCombineStats.all(season: 2019).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /draftcombinestats/).to_return(body: {}.to_json)

      assert_equal 0, DraftCombineStats.all(season: 2019).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "Results", rowSet: [[1]]}]}
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineStats.all(season: 2019).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "Results", headers: %w[PLAYER_ID]}]}
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineStats.all(season: 2019).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineStats.all(season: 2019).size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "Results", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineStats.all(season: 2019).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "Results", headers: %w[PLAYER_ID], rowSet: nil}]}
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineStats.all(season: 2019).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "Results", headers: basic_headers, rowSet: [basic_row]}
      ]}
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      results = DraftCombineStats.all(season: 2019)

      assert_equal 1, results.size
      assert_equal 1_630_162, results.first.player_id
    end

    def test_finds_result_set_when_not_last
      wrong_row = ["2023-24", 999_999, "Wrong", "Player", "Wrong Player", "G"]
      response = {resultSets: [
        {name: "Results", headers: basic_headers, rowSet: [basic_row]},
        {name: "Other", headers: basic_headers, rowSet: [wrong_row]}
      ]}
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      results = DraftCombineStats.all(season: 2019)

      assert_equal 1, results.size
      assert_equal "Victor Wembanyama", results.first.player_name
    end

    def test_handles_multiple_results
      stub_request(:get, /draftcombinestats/).to_return(body: multi_result_response.to_json)

      results = DraftCombineStats.all(season: 2019)

      assert_equal 2, results.size
      assert_equal 1_630_162, results.first.player_id
      assert_equal 1_630_163, results.last.player_id
    end

    def test_handles_missing_optional_fields
      response = {resultSets: [{name: "Results", headers: basic_headers, rowSet: [basic_row]}]}
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      result = DraftCombineStats.all(season: 2019).first

      assert_equal 1_630_162, result.player_id
      assert_equal "Victor Wembanyama", result.player_name
      assert_nil result.height_wo_shoes
    end

    def test_returns_empty_when_result_set_name_missing
      response = {resultSets: [{headers: basic_headers, rowSet: [basic_row]}]}
      stub_request(:get, /draftcombinestats/).to_return(body: response.to_json)

      assert_equal 0, DraftCombineStats.all(season: 2019).size
    end

    private

    def basic_headers
      %w[SEASON PLAYER_ID FIRST_NAME LAST_NAME PLAYER_NAME POSITION]
    end

    def basic_row
      ["2023-24", 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C"]
    end

    def multi_result_response
      rows = [
        ["2023-24", 1_630_162, "Victor", "Wembanyama", "Victor Wembanyama", "C"],
        ["2023-24", 1_630_163, "Brandon", "Miller", "Brandon Miller", "F"]
      ]
      {resultSets: [{name: "Results", headers: basic_headers, rowSet: rows}]}
    end
  end
end
