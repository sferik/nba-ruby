require_relative "../../test_helper"

module NBA
  class DunkScoreLeadersEdgeCasesEmptyTest < Minitest::Test
    cover DunkScoreLeaders

    def test_all_returns_empty_collection_when_response_nil
      stub_request(:get, /dunkscoreleaders/).to_return(body: nil)

      result = DunkScoreLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_result_sets_missing
      stub_request(:get, /dunkscoreleaders/).to_return(body: {}.to_json)

      result = DunkScoreLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_result_set_not_found
      stub_request(:get, /dunkscoreleaders/)
        .to_return(body: {resultSets: [{name: "OtherSet", headers: [], rowSet: []}]}.to_json)

      result = DunkScoreLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end
  end
end
