require_relative "../../test_helper"

module NBA
  class VideoEventsAssetEdgeCasesEmptyTest < Minitest::Test
    cover VideoEventsAsset

    def test_all_returns_empty_collection_when_response_nil
      client = Minitest::Mock.new
      client.expect(:get, nil, [String])

      result = VideoEventsAsset.all(game: "0022300001", client: client)

      assert_instance_of Collection, result
      assert_empty result
      client.verify
    end

    def test_all_returns_empty_collection_when_response_empty
      stub_request(:get, /videoeventsasset/).to_return(body: "")

      result = VideoEventsAsset.all(game: "0022300001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_result_sets_missing
      stub_request(:get, /videoeventsasset/).to_return(body: {}.to_json)

      result = VideoEventsAsset.all(game: "0022300001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_headers_nil
      stub_request(:get, /videoeventsasset/)
        .to_return(body: {resultSets: [{headers: nil, rowSet: [["data"]]}]}.to_json)

      result = VideoEventsAsset.all(game: "0022300001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_headers_key_missing
      stub_request(:get, /videoeventsasset/)
        .to_return(body: {resultSets: [{rowSet: []}]}.to_json)

      result = VideoEventsAsset.all(game: "0022300001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_row_set_missing
      stub_request(:get, /videoeventsasset/)
        .to_return(body: {resultSets: [{headers: []}]}.to_json)

      result = VideoEventsAsset.all(game: "0022300001")

      assert_instance_of Collection, result
      assert_empty result
    end
  end
end
