require_relative "../../test_helper"

module NBA
  class TeamInfoCommonSeasonsEdgeCasesTest < Minitest::Test
    cover TeamInfoCommon

    def test_available_seasons_returns_empty_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamInfoCommon.available_seasons(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_available_seasons_returns_empty_for_missing_result_set
      mock_client = Minitest::Mock.new
      mock_client.expect :get, {resultSets: []}.to_json, [String]

      result = TeamInfoCommon.available_seasons(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_available_seasons_returns_empty_for_missing_rows
      mock_client = Minitest::Mock.new
      response = {resultSets: [{name: "AvailableSeasons", headers: ["SEASON_ID"]}]}.to_json
      mock_client.expect :get, response, [String]

      result = TeamInfoCommon.available_seasons(team: 1_610_612_744, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_available_seasons_with_multiple_rows
      mock_client = Minitest::Mock.new
      response = {resultSets: [{name: "AvailableSeasons", headers: ["SEASON_ID"],
                                rowSet: [["2024-25"], ["2023-24"], ["2022-23"]]}]}.to_json
      mock_client.expect :get, response, [String]

      result = TeamInfoCommon.available_seasons(team: 1_610_612_744, client: mock_client)

      assert_equal "2024-25", result.first
      assert_equal 3, result.size
    end

    def test_available_seasons_extracts_first_element_from_each_row
      mock_client = Minitest::Mock.new
      response = {resultSets: [{name: "AvailableSeasons", headers: %w[SEASON_ID OTHER],
                                rowSet: [%w[2024-25 extra1], %w[2023-24 extra2]]}]}.to_json
      mock_client.expect :get, response, [String]

      result = TeamInfoCommon.available_seasons(team: 1_610_612_744, client: mock_client)

      assert_equal "2024-25", result.first
      assert_equal "2023-24", result.last
    end
  end
end
