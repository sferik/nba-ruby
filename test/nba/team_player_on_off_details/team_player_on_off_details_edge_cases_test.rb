require_relative "../../test_helper"

module NBA
  class TeamPlayerOnOffDetailsEdgeCasesTest < Minitest::Test
    cover TeamPlayerOnOffDetails

    def test_overall_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_overall_returns_empty_collection_for_missing_result_sets
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: {}.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_overall_returns_empty_collection_for_missing_result_set
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: {resultSets: []}.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_overall_returns_empty_collection_for_missing_headers
      response = {resultSets: [{name: "OverallTeamPlayerOnOffDetails", rowSet: []}]}
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_overall_returns_empty_collection_for_missing_row_set
      response = {resultSets: [{name: "OverallTeamPlayerOnOffDetails", headers: []}]}
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_players_on_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamPlayerOnOffDetails.players_on_court(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_players_off_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamPlayerOnOffDetails.players_off_court(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_result_set_name_must_match_exactly
      response = {resultSets: [{name: "WrongName", headers: [], rowSet: []}]}
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_overall_handles_result_set_without_name_key
      response = {resultSets: [{headers: [], rowSet: []}]}
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_overall_returns_empty_when_headers_nil_but_rows_present
      response = {resultSets: [{name: "OverallTeamPlayerOnOffDetails", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /teamplayeronoffdetails/).to_return(body: response.to_json)

      result = TeamPlayerOnOffDetails.overall(team: 1_610_612_744)

      assert_empty result
    end
  end
end
