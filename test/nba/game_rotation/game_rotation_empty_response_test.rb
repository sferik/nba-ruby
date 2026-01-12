require_relative "../../test_helper"

module NBA
  class GameRotationEmptyResponseTest < Minitest::Test
    cover GameRotation

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, GameRotation.home_team(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /gamerotation/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, GameRotation.home_team(game: "001").size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /gamerotation/).to_return(body: {}.to_json)

      assert_equal 0, GameRotation.home_team(game: "001").size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_equal 0, GameRotation.home_team(game: "001").size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "HomeTeam", headers: nil, rowSet: [["data"]]}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_equal 0, GameRotation.home_team(game: "001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "HomeTeam", rowSet: [["data"]]}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_equal 0, GameRotation.home_team(game: "001").size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "HomeTeam", headers: %w[TEAM_ID], rowSet: nil}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_equal 0, GameRotation.home_team(game: "001").size
    end

    def test_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "HomeTeam", headers: %w[TEAM_ID]}]}
      stub_request(:get, /gamerotation/).to_return(body: response.to_json)

      assert_equal 0, GameRotation.home_team(game: "001").size
    end
  end
end
