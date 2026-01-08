require_relative "../test_helper"

module NBA
  class LeagueDashTeamPtShotEdgeCasesTest < Minitest::Test
    cover LeagueDashTeamPtShot

    def test_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueDashTeamPtShot.all(season: 2024, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_returns_empty_collection_for_empty_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, "", [String]

      result = LeagueDashTeamPtShot.all(season: 2024, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_returns_empty_collection_when_result_sets_missing
      stub_request(:get, /leaguedashteamptshot/).to_return(body: {}.to_json)

      assert_empty LeagueDashTeamPtShot.all(season: 2024)
    end

    def test_returns_empty_collection_when_result_set_not_found
      response = {resultSets: [{name: "OtherResultSet", headers: %w[TEAM_ID], rowSet: [[999]]}]}
      stub_request(:get, /leaguedashteamptshot/).to_return(body: response.to_json)

      assert_empty LeagueDashTeamPtShot.all(season: 2024)
    end

    def test_ignores_result_set_with_wrong_name
      other_set = {name: "OtherResultSet", headers: %w[TEAM_ID], rowSet: [[999]]}
      correct_set = {name: "LeagueDashPTShots", headers: %w[TEAM_ID], rowSet: [[Team::GSW]]}
      response = {resultSets: [other_set, correct_set]}
      stub_request(:get, /leaguedashteamptshot/).to_return(body: response.to_json)

      result = LeagueDashTeamPtShot.all(season: 2024)

      assert_equal Team::GSW, result.first.team_id
    end

    def test_returns_empty_collection_when_headers_missing
      response = {resultSets: [{name: "LeagueDashPTShots", rowSet: [[Team::GSW]]}]}
      stub_request(:get, /leaguedashteamptshot/).to_return(body: response.to_json)

      assert_empty LeagueDashTeamPtShot.all(season: 2024)
    end

    def test_returns_empty_collection_when_row_set_missing
      response = {resultSets: [{name: "LeagueDashPTShots", headers: %w[TEAM_ID]}]}
      stub_request(:get, /leaguedashteamptshot/).to_return(body: response.to_json)

      assert_empty LeagueDashTeamPtShot.all(season: 2024)
    end

    def test_returns_empty_collection_when_name_missing_from_result_set
      response = {resultSets: [{headers: %w[TEAM_ID], rowSet: [[Team::GSW]]}]}
      stub_request(:get, /leaguedashteamptshot/).to_return(body: response.to_json)

      assert_empty LeagueDashTeamPtShot.all(season: 2024)
    end
  end
end
