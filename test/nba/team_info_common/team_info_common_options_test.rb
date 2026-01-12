require_relative "../../test_helper"

module NBA
  class TeamInfoCommonOptionsTest < Minitest::Test
    cover TeamInfoCommon

    def test_available_seasons_returns_collection
      stub_team_info_request

      result = TeamInfoCommon.available_seasons(team: 1_610_612_744)

      assert_instance_of Collection, result
    end

    def test_available_seasons_parses_season_ids
      stub_team_info_request

      result = TeamInfoCommon.available_seasons(team: 1_610_612_744)

      assert_includes result, "2024-25"
      assert_includes result, "2023-24"
    end

    def test_find_uses_current_season_by_default
      mock_client = Minitest::Mock.new
      expected_season = Utils.format_season(Utils.current_season)
      mock_client.expect :get, full_response.to_json do |path|
        path.include?("Season=#{expected_season}")
      end

      TeamInfoCommon.find(team: 1_610_612_744, client: mock_client)

      mock_client.verify
    end

    def test_find_includes_season_in_path
      mock_client = Minitest::Mock.new
      mock_client.expect :get, full_response.to_json do |path|
        path.include?("Season=2023-24")
      end

      TeamInfoCommon.find(team: 1_610_612_744, season: 2023, client: mock_client)

      mock_client.verify
    end

    def test_ranks_uses_current_season_by_default
      mock_client = Minitest::Mock.new
      expected_season = Utils.format_season(Utils.current_season)
      mock_client.expect :get, full_response.to_json do |path|
        path.include?("Season=#{expected_season}")
      end

      TeamInfoCommon.ranks(team: 1_610_612_744, client: mock_client)

      mock_client.verify
    end

    def test_find_includes_season_type_in_path
      mock_client = Minitest::Mock.new
      mock_client.expect :get, full_response.to_json do |path|
        path.include?("SeasonType=Playoffs")
      end

      TeamInfoCommon.find(team: 1_610_612_744, season_type: "Playoffs", client: mock_client)

      mock_client.verify
    end

    private

    def stub_team_info_request
      stub_request(:get, /teaminfocommon.*TeamID=1610612744/).to_return(body: full_response.to_json)
    end

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
