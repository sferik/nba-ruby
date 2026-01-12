require_relative "../../test_helper"

module NBA
  class LeagueDashPtStatsSpeedMappingTest < Minitest::Test
    cover LeagueDashPtStats

    def test_maps_dist_feet
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_in_delta 12_500.5, stat.dist_feet
    end

    def test_maps_dist_miles
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_in_delta 2.37, stat.dist_miles
    end

    def test_maps_dist_miles_off
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_in_delta 1.15, stat.dist_miles_off
    end

    def test_maps_dist_miles_def
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_in_delta 1.22, stat.dist_miles_def
    end

    def test_maps_avg_speed
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_in_delta 4.25, stat.avg_speed
    end

    def test_maps_avg_speed_off
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_in_delta 4.15, stat.avg_speed_off
    end

    def test_maps_avg_speed_def
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_in_delta 4.35, stat.avg_speed_def
    end

    private

    def stub_pt_stats_request
      stub_request(:get, /leaguedashptstats/).to_return(body: pt_stats_response.to_json)
    end

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
