require_relative "../../test_helper"

module NBA
  class PlayerDashPtRebEdgeCasesTest < Minitest::Test
    cover PlayerDashPtReb

    def test_returns_empty_when_result_set_not_found
      stub_request(:get, /playerdashptreb/).to_return(body: {resultSets: []}.to_json)

      stats = PlayerDashPtReb.overall(player: 201_939)

      assert_empty stats
    end

    def test_returns_empty_when_headers_missing
      response = {resultSets: [{name: "OverallRebounding", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playerdashptreb/).to_return(body: response.to_json)

      stats = PlayerDashPtReb.overall(player: 201_939)

      assert_empty stats
    end

    def test_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "OverallRebounding", headers: %w[A B C]}]}
      stub_request(:get, /playerdashptreb/).to_return(body: response.to_json)

      stats = PlayerDashPtReb.overall(player: 201_939)

      assert_empty stats
    end

    def test_returns_empty_when_result_sets_missing
      stub_request(:get, /playerdashptreb/).to_return(body: {}.to_json)

      stats = PlayerDashPtReb.overall(player: 201_939)

      assert_empty stats
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: %w[A B C], rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playerdashptreb/).to_return(body: response.to_json)

      stats = PlayerDashPtReb.overall(player: 201_939)

      assert_empty stats
    end
  end
end
