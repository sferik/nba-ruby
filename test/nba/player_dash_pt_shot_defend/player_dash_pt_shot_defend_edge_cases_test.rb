require_relative "../../test_helper"

module NBA
  class PlayerDashPtShotDefendEdgeCasesTest < Minitest::Test
    cover PlayerDashPtShotDefend

    def test_returns_empty_when_result_set_not_found
      stub_request(:get, /playerdashptshotdefend/).to_return(body: {resultSets: []}.to_json)

      assert_empty PlayerDashPtShotDefend.find(player: 201_939)
    end

    def test_returns_empty_when_headers_missing
      response = {resultSets: [{name: "DefendingShots", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playerdashptshotdefend/).to_return(body: response.to_json)

      assert_empty PlayerDashPtShotDefend.find(player: 201_939)
    end

    def test_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "DefendingShots", headers: %w[A B C]}]}
      stub_request(:get, /playerdashptshotdefend/).to_return(body: response.to_json)

      assert_empty PlayerDashPtShotDefend.find(player: 201_939)
    end

    def test_returns_empty_when_result_sets_missing
      stub_request(:get, /playerdashptshotdefend/).to_return(body: {}.to_json)

      assert_empty PlayerDashPtShotDefend.find(player: 201_939)
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: %w[A B C], rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /playerdashptshotdefend/).to_return(body: response.to_json)

      assert_empty PlayerDashPtShotDefend.find(player: 201_939)
    end

    def test_selects_correct_result_set_by_name
      response = {resultSets: [
        {name: "OtherResultSet", headers: %w[CLOSE_DEF_PERSON_ID DEFENSE_CATEGORY],
         rowSet: [[999_999, "Wrong"]]},
        {name: "DefendingShots", headers: %w[CLOSE_DEF_PERSON_ID DEFENSE_CATEGORY],
         rowSet: [[201_939, "Correct"]]}
      ]}
      stub_request(:get, /playerdashptshotdefend/).to_return(body: response.to_json)

      assert_equal "Correct", PlayerDashPtShotDefend.find(player: 201_939).first.defense_category
    end
  end
end
