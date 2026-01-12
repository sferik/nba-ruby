require_relative "../../test_helper"

module NBA
  class LeagueDashPtStatsAllTest < Minitest::Test
    cover LeagueDashPtStats

    def test_all_returns_collection
      stub_request(:get, /leaguedashptstats/).to_return(body: pt_stats_response.to_json)

      assert_instance_of Collection, LeagueDashPtStats.all(season: 2024)
    end

    def test_all_uses_correct_result_set
      stub_request(:get, /leaguedashptstats/).to_return(body: pt_stats_response.to_json)

      result = LeagueDashPtStats.all(season: 2024)

      assert_equal 201_939, result.first.player_id
    end

    def test_all_with_season_type_playoffs
      stub = stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: pt_stats_response.to_json)

      LeagueDashPtStats.all(season: 2024, season_type: LeagueDashPtStats::PLAYOFFS)

      assert_requested stub
    end

    def test_all_with_per_mode_totals
      stub = stub_request(:get, /PerMode=Totals/)
        .to_return(body: pt_stats_response.to_json)

      LeagueDashPtStats.all(season: 2024, per_mode: LeagueDashPtStats::TOTALS)

      assert_requested stub
    end

    def test_all_with_player_or_team_team
      stub = stub_request(:get, /PlayerOrTeam=Team/)
        .to_return(body: pt_stats_response.to_json)

      LeagueDashPtStats.all(season: 2024, player_or_team: LeagueDashPtStats::TEAM)

      assert_requested stub
    end

    def test_all_with_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, pt_stats_response.to_json, [String]

      LeagueDashPtStats.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def pt_stats_response
      {resultSets: [{name: "LeagueDashPtStats", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION TEAM_NAME AGE GP W L MIN
        DIST_FEET DIST_MILES DIST_MILES_OFF DIST_MILES_DEF AVG_SPEED AVG_SPEED_OFF AVG_SPEED_DEF]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", "Golden State Warriors", 36.0, 82, 50, 32, 32.5,
        12_500.5, 2.37, 1.15, 1.22, 4.25, 4.15, 4.35]
    end
  end
end
