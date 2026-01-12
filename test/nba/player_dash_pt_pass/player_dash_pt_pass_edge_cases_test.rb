require_relative "../../test_helper"

module NBA
  class PlayerDashPtPassEdgeCasesTest < Minitest::Test
    cover PlayerDashPtPass

    def test_returns_empty_when_result_set_not_found
      stub_request(:get, /playerdashptpass/).to_return(body: {resultSets: []}.to_json)

      assert_empty PlayerDashPtPass.passes_made(player: 201_939)
    end

    def test_returns_empty_when_headers_missing
      response = {resultSets: [{name: "PassesMade", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playerdashptpass/).to_return(body: response.to_json)

      assert_empty PlayerDashPtPass.passes_made(player: 201_939)
    end

    def test_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "PassesMade", headers: %w[A B C]}]}
      stub_request(:get, /playerdashptpass/).to_return(body: response.to_json)

      assert_empty PlayerDashPtPass.passes_made(player: 201_939)
    end

    def test_returns_empty_when_result_sets_missing
      stub_request(:get, /playerdashptpass/).to_return(body: {}.to_json)

      assert_empty PlayerDashPtPass.passes_made(player: 201_939)
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: %w[A B C], rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playerdashptpass/).to_return(body: response.to_json)

      assert_empty PlayerDashPtPass.passes_made(player: 201_939)
    end
  end
end
