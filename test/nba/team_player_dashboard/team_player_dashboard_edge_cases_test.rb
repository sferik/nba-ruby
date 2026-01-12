require_relative "../../test_helper"

module NBA
  class TeamPlayerDashboardEdgeCasesTest < Minitest::Test
    cover TeamPlayerDashboard

    def test_players_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamPlayerDashboard.players(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_players_returns_empty_collection_for_missing_result_sets
      stub_request(:get, /teamplayerdashboard/).to_return(body: {}.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_empty result
    end

    def test_players_returns_empty_collection_for_missing_result_set
      stub_request(:get, /teamplayerdashboard/).to_return(body: {resultSets: []}.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_empty result
    end

    def test_players_returns_empty_collection_for_missing_headers
      response = {resultSets: [{name: "PlayersSeasonTotals", rowSet: []}]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_empty result
    end

    def test_players_returns_empty_collection_for_missing_row_set
      response = {resultSets: [{name: "PlayersSeasonTotals", headers: []}]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_empty result
    end

    def test_team_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamPlayerDashboard.team(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_team_returns_empty_collection_for_missing_result_sets
      stub_request(:get, /teamplayerdashboard/).to_return(body: {}.to_json)

      result = TeamPlayerDashboard.team(team: 1_610_612_744)

      assert_empty result
    end

    def test_team_returns_empty_collection_for_missing_result_set
      stub_request(:get, /teamplayerdashboard/).to_return(body: {resultSets: []}.to_json)

      result = TeamPlayerDashboard.team(team: 1_610_612_744)

      assert_empty result
    end

    def test_result_set_name_must_match_exactly
      response = {resultSets: [{name: "WrongName", headers: [], rowSet: []}]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_empty result
    end

    def test_players_returns_empty_when_headers_missing_but_rows_present
      response = {resultSets: [{name: "PlayersSeasonTotals", rowSet: [["data"]]}]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_empty result
    end

    def test_players_handles_result_set_without_name_key
      response = {resultSets: [{headers: [], rowSet: []}]}
      stub_request(:get, /teamplayerdashboard/).to_return(body: response.to_json)

      result = TeamPlayerDashboard.players(team: 1_610_612_744)

      assert_empty result
    end
  end
end
