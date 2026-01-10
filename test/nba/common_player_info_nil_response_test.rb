require_relative "common_player_info_test_helpers"

module NBA
  class CommonPlayerInfoNilResponseTest < Minitest::Test
    include CommonPlayerInfoTestHelpers

    cover CommonPlayerInfo

    def test_returns_nil_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = CommonPlayerInfo.find(player: 201_939, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_returns_nil_when_no_result_sets
      stub_request(:get, /commonplayerinfo/).to_return(body: {resultSets: nil}.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_result_sets_key_missing
      stub_request(:get, /commonplayerinfo/).to_return(body: {}.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_headers_key_missing
      response = {resultSets: [{name: "CommonPlayerInfo", rowSet: [[1]]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_row_set_key_missing
      response = {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_no_headers
      response = {resultSets: [{name: "CommonPlayerInfo", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_no_rows
      response = {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID], rowSet: nil}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end

    def test_returns_nil_when_row_set_empty
      response = {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID], rowSet: []}]}
      stub_request(:get, /commonplayerinfo/).to_return(body: response.to_json)

      assert_nil CommonPlayerInfo.find(player: 201_939)
    end
  end
end
