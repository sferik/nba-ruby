require_relative "../../test_helper"

module NBA
  class AssistLeadersEdgeCasesEmptyTest < Minitest::Test
    cover AssistLeaders

    def test_all_handles_nil_response
      stub_request(:get, /assistleaders/).to_return(body: nil)

      result = AssistLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /assistleaders/).to_return(body: {resultSets: []}.to_json)

      result = AssistLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_set
      stub_request(:get, /assistleaders/).to_return(body: {resultSets: [{name: "Other", headers: [], rowSet: []}]}.to_json)

      result = AssistLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "AssistLeaders", headers: %w[RANK PLAYER_ID PLAYER_NAME], rowSet: []}]}
      stub_request(:get, /assistleaders/).to_return(body: response.to_json)

      result = AssistLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end
  end
end
