require_relative "../test_helper"

module NBA
  class TeamInfoCommonFindEdgeCasesTest < Minitest::Test
    cover TeamInfoCommon

    def test_find_returns_nil_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = TeamInfoCommon.find(team: 1_610_612_744, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_find_returns_nil_for_missing_result_set
      mock_client = Minitest::Mock.new
      mock_client.expect :get, {resultSets: []}.to_json, [String]

      result = TeamInfoCommon.find(team: 1_610_612_744, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_find_returns_nil_for_empty_row_set
      mock_client = Minitest::Mock.new
      response = {resultSets: [{name: "TeamInfoCommon", headers: info_headers, rowSet: []}]}.to_json
      mock_client.expect :get, response, [String]

      result = TeamInfoCommon.find(team: 1_610_612_744, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_find_returns_nil_for_missing_headers
      mock_client = Minitest::Mock.new
      response = {resultSets: [{name: "TeamInfoCommon", rowSet: [info_row]}]}.to_json
      mock_client.expect :get, response, [String]

      result = TeamInfoCommon.find(team: 1_610_612_744, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_find_returns_nil_for_missing_result_sets_key
      mock_client = Minitest::Mock.new
      mock_client.expect :get, {}.to_json, [String]

      result = TeamInfoCommon.find(team: 1_610_612_744, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_find_returns_nil_for_missing_row_set_key
      mock_client = Minitest::Mock.new
      response = {resultSets: [{name: "TeamInfoCommon", headers: info_headers}]}.to_json
      mock_client.expect :get, response, [String]

      result = TeamInfoCommon.find(team: 1_610_612_744, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_find_handles_result_set_missing_name_key
      mock_client = Minitest::Mock.new
      response = {resultSets: [{headers: info_headers, rowSet: [info_row]}]}.to_json
      mock_client.expect :get, response, [String]

      result = TeamInfoCommon.find(team: 1_610_612_744, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_find_excludes_season_type_when_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, full_response.to_json do |path|
        !path.include?("SeasonType=")
      end

      TeamInfoCommon.find(team: 1_610_612_744, season_type: nil, client: mock_client)

      mock_client.verify
    end

    def test_find_excludes_season_when_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, full_response.to_json do |path|
        !path.include?("Season=")
      end

      TeamInfoCommon.find(team: 1_610_612_744, season: nil, client: mock_client)

      mock_client.verify
    end

    private

    def full_response
      {resultSets: [
        {name: "TeamInfoCommon", headers: info_headers, rowSet: [info_row]},
        {name: "TeamSeasonRanks", headers: rank_headers, rowSet: [rank_row]},
        {name: "AvailableSeasons", headers: ["SEASON_ID"], rowSet: [["2024-25"], ["2023-24"]]}
      ]}
    end

    def info_headers
      %w[TEAM_ID SEASON_YEAR TEAM_CITY TEAM_NAME TEAM_ABBREVIATION TEAM_CONFERENCE TEAM_DIVISION
        TEAM_CODE TEAM_SLUG W L PCT CONF_RANK DIV_RANK MIN_YEAR MAX_YEAR]
    end

    def info_row
      [1_610_612_744, "2024-25", "Golden State", "Warriors", "GSW", "West", "Pacific",
        "warriors", "warriors", 46, 36, 0.561, 4, 2, "1946", "2024"]
    end

    def rank_headers
      %w[LEAGUE_ID SEASON_ID TEAM_ID PTS_RANK PTS_PG REB_RANK REB_PG AST_RANK AST_PG OPP_PTS_RANK OPP_PTS_PG]
    end

    def rank_row
      ["00", "2024-25", 1_610_612_744, 5, 118.9, 12, 44.2, 3, 28.7, 15, 115.2]
    end
  end
end
