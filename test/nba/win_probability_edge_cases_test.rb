require_relative "../test_helper"
require_relative "win_probability_test_helpers"

module NBA
  class WinProbabilityEdgeCasesTest < Minitest::Test
    include WinProbabilityTestHelpers

    cover WinProbability

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /winprobabilitypbp/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, WinProbability.find(game: "0022400001").size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "OtherResultSet", headers: [], rowSet: []}]}
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)

      assert_equal 0, WinProbability.find(game: "0022400001").size
    end

    def test_returns_empty_when_headers_nil
      response = {resultSets: [{name: "WinProbPBP", headers: nil, rowSet: [["data"]]}]}
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)

      assert_equal 0, WinProbability.find(game: "0022400001").size
    end

    def test_returns_empty_when_rows_nil
      response = {resultSets: [{name: "WinProbPBP", headers: ["EVENT_NUM"], rowSet: nil}]}
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)

      assert_equal 0, WinProbability.find(game: "0022400001").size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: [], rowSet: []}]}
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)

      assert_equal 0, WinProbability.find(game: "0022400001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "WinProbPBP", rowSet: [["data"]]}]}
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)

      assert_equal 0, WinProbability.find(game: "0022400001").size
    end

    def test_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "WinProbPBP", headers: ["EVENT_NUM"]}]}
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)

      assert_equal 0, WinProbability.find(game: "0022400001").size
    end

    def test_returns_empty_when_result_sets_key_missing
      response = {}
      stub_request(:get, /winprobabilitypbp/).to_return(body: response.to_json)

      assert_equal 0, WinProbability.find(game: "0022400001").size
    end
  end
end
