require_relative "../../test_helper"

module NBA
  class LivePlayByPlayEdgeCasesTest < Minitest::Test
    cover LivePlayByPlay

    def test_find_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, LivePlayByPlay.find(game: "0022400001", client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_collection_when_no_actions
      response = {game: {actions: nil}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      assert_equal 0, LivePlayByPlay.find(game: "0022400001").size
    end

    def test_find_returns_empty_collection_when_no_game_data
      stub_request(:get, /cdn.nba.com/).to_return(body: {}.to_json)

      assert_equal 0, LivePlayByPlay.find(game: "0022400001").size
    end
  end
end
