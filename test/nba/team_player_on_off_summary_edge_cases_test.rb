require_relative "../test_helper"

module NBA
  class TeamPlayerOnOffSummaryEdgeCasesTest < Minitest::Test
    cover TeamPlayerOnOffSummary

    def test_overall_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_overall_returns_empty_collection_for_missing_result_sets
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: {}.to_json)

      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_overall_returns_empty_collection_for_missing_result_set
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: {resultSets: []}.to_json)

      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_overall_returns_empty_collection_for_missing_headers
      response = {resultSets: [{name: "OverallTeamPlayerOnOffSummary", rowSet: []}]}
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response.to_json)

      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_overall_returns_empty_collection_for_missing_row_set
      response = {resultSets: [{name: "OverallTeamPlayerOnOffSummary", headers: []}]}
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response.to_json)

      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_players_on_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamPlayerOnOffSummary.players_on_court(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_players_off_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamPlayerOnOffSummary.players_off_court(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_result_set_name_must_match_exactly
      response = {resultSets: [{name: "WrongName", headers: [], rowSet: []}]}
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response.to_json)

      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_empty result
    end

    def test_overall_handles_result_set_without_name_key
      response = {resultSets: [{headers: [], rowSet: []}]}
      stub_request(:get, /teamplayeronoffsummary/).to_return(body: response.to_json)

      result = TeamPlayerOnOffSummary.overall(team: 1_610_612_744)

      assert_empty result
    end
  end
end
