require_relative "../test_helper"

module NBA
  class LeagueDashPlayerBioStatsAllTest < Minitest::Test
    cover LeagueDashPlayerBioStats

    def test_all_returns_collection
      stub_request(:get, /leaguedashplayerbiostats/).to_return(body: bio_stats_response.to_json)

      assert_instance_of Collection, LeagueDashPlayerBioStats.all(season: 2024)
    end

    def test_all_uses_correct_result_set
      stub_request(:get, /leaguedashplayerbiostats/).to_return(body: bio_stats_response.to_json)

      result = LeagueDashPlayerBioStats.all(season: 2024)

      assert_equal 201_939, result.first.player_id
    end

    def test_all_with_season_type_parameter
      stub = stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: bio_stats_response.to_json)

      LeagueDashPlayerBioStats.all(season: 2024, season_type: LeagueDashPlayerBioStats::PLAYOFFS)

      assert_requested stub
    end

    def test_all_with_per_mode_parameter
      stub = stub_request(:get, /PerMode=Totals/)
        .to_return(body: bio_stats_response.to_json)

      LeagueDashPlayerBioStats.all(season: 2024, per_mode: LeagueDashPlayerBioStats::TOTALS)

      assert_requested stub
    end

    def test_all_with_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, bio_stats_response.to_json, [String]

      LeagueDashPlayerBioStats.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def bio_stats_response
      {resultSets: [{name: "LeagueDashPlayerBioStats", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE PLAYER_HEIGHT PLAYER_HEIGHT_INCHES
        PLAYER_WEIGHT COLLEGE COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER GP PTS REB AST
        NET_RATING OREB_PCT DREB_PCT USG_PCT TS_PCT AST_PCT]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36.0, "6-2", 74, 185, "Davidson", "USA",
        "2009", "1", "7", 74, 26.4, 5.2, 6.1, 8.5, 0.025, 0.112, 0.298, 0.621, 0.312]
    end
  end
end
