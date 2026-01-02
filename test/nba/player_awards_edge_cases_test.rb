require_relative "../test_helper"

module NBA
  class PlayerAwardsEdgeCasesTest < Minitest::Test
    cover PlayerAwards

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, PlayerAwards.find(player: 201_939, client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /playerawards/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, PlayerAwards.find(player: 201_939).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /playerawards/).to_return(body: {}.to_json)

      assert_equal 0, PlayerAwards.find(player: 201_939).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /playerawards/).to_return(body: response.to_json)

      assert_equal 0, PlayerAwards.find(player: 201_939).size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "PlayerAwards", headers: nil, rowSet: [["data"]]}]}
      stub_request(:get, /playerawards/).to_return(body: response.to_json)

      assert_equal 0, PlayerAwards.find(player: 201_939).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "PlayerAwards", headers: %w[DESCRIPTION], rowSet: nil}]}
      stub_request(:get, /playerawards/).to_return(body: response.to_json)

      assert_equal 0, PlayerAwards.find(player: 201_939).size
    end

    def test_raises_key_error_when_result_set_name_key_missing
      response = {resultSets: [{headers: [], rowSet: []}]}
      stub_request(:get, /playerawards/).to_return(body: response.to_json)

      assert_raises(KeyError) { PlayerAwards.find(player: 201_939) }
    end

    def test_finds_correct_result_set_by_name_when_multiple_exist
      stub_request(:get, /playerawards/).to_return(body: multiple_result_sets_response.to_json)

      awards = PlayerAwards.find(player: 201_939)

      assert_equal 1, awards.size
      assert_equal "MVP", awards.first.description
    end

    def test_selects_result_set_with_exact_name_match
      headers = %w[FIRST_NAME LAST_NAME TEAM DESCRIPTION ALL_NBA_TEAM_NUMBER
        SEASON MONTH WEEK CONFERENCE TYPE SUBTYPE1 SUBTYPE2 SUBTYPE3]
      row = ["Stephen", "Curry", "Warriors", "Finals MVP", nil, "2021-22", nil, nil, nil, "Playoff", nil, nil, nil]
      response = {resultSets: [
        {name: "PlayerAwardsExtra", headers: %w[FOO], rowSet: [["wrong"]]},
        {name: "PlayerAwards", headers: headers, rowSet: [row]}
      ]}
      stub_request(:get, /playerawards/).to_return(body: response.to_json)

      awards = PlayerAwards.find(player: 201_939)

      assert_equal "Finals MVP", awards.first.description
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "PlayerAwards", rowSet: [["data"]]}]}
      stub_request(:get, /playerawards/).to_return(body: response.to_json)

      assert_equal 0, PlayerAwards.find(player: 201_939).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "PlayerAwards", headers: %w[DESCRIPTION]}]}
      stub_request(:get, /playerawards/).to_return(body: response.to_json)

      assert_equal 0, PlayerAwards.find(player: 201_939).size
    end

    private

    def multiple_result_sets_response
      headers = %w[FIRST_NAME LAST_NAME TEAM DESCRIPTION ALL_NBA_TEAM_NUMBER
        SEASON MONTH WEEK CONFERENCE TYPE SUBTYPE1 SUBTYPE2 SUBTYPE3]
      row = ["Stephen", "Curry", "Warriors", "MVP", nil, "2021-22", nil, nil, nil, "Regular", nil, nil, nil]
      {resultSets: [
        {name: "OtherResultSet", headers: %w[FOO], rowSet: [["wrong"]]},
        {name: "PlayerAwards", headers: headers, rowSet: [row]},
        {name: "AnotherResultSet", headers: %w[BAR], rowSet: [["also_wrong"]]}
      ]}
    end
  end
end
