require_relative "../test_helper"

module NBA
  class PlayerDashPtShotsEdgeCasesTest < Minitest::Test
    cover PlayerDashPtShots

    def test_returns_empty_when_result_set_not_found
      stub_request(:get, /playerdashptshots/).to_return(body: {resultSets: []}.to_json)

      assert_empty PlayerDashPtShots.overall(player: 201_939)
    end

    def test_returns_empty_when_headers_missing
      response = {resultSets: [{name: "Overall", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playerdashptshots/).to_return(body: response.to_json)

      assert_empty PlayerDashPtShots.overall(player: 201_939)
    end

    def test_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "Overall", headers: %w[A B C]}]}
      stub_request(:get, /playerdashptshots/).to_return(body: response.to_json)

      assert_empty PlayerDashPtShots.overall(player: 201_939)
    end

    def test_returns_empty_when_result_sets_missing
      stub_request(:get, /playerdashptshots/).to_return(body: {}.to_json)

      assert_empty PlayerDashPtShots.overall(player: 201_939)
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: %w[A B C], rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playerdashptshots/).to_return(body: response.to_json)

      assert_empty PlayerDashPtShots.overall(player: 201_939)
    end

    def test_selects_correct_result_set_by_name
      response = {resultSets: [
        {name: "OtherResultSet", headers: %w[PLAYER_ID SHOT_TYPE], rowSet: [[999_999, "Wrong"]]},
        {name: "Overall", headers: %w[PLAYER_ID SHOT_TYPE], rowSet: [[201_939, "Correct"]]}
      ]}
      stub_request(:get, /playerdashptshots/).to_return(body: response.to_json)

      assert_equal "Correct", PlayerDashPtShots.overall(player: 201_939).first.shot_type
    end
  end
end
