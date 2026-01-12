require_relative "../../test_helper"

module NBA
  class LeagueDashPtStatsIdentityMappingTest < Minitest::Test
    cover LeagueDashPtStats

    def test_maps_player_id
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_equal 201_939, stat.player_id
    end

    def test_maps_player_name
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_equal "Stephen Curry", stat.player_name
    end

    def test_maps_team_id
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_equal Team::GSW, stat.team_id
    end

    def test_maps_team_abbreviation
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_maps_team_name
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_equal "Golden State Warriors", stat.team_name
    end

    def test_maps_age
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_in_delta 36.0, stat.age
    end

    def test_maps_gp
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_equal 82, stat.gp
    end

    def test_maps_w
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_equal 50, stat.w
    end

    def test_maps_l
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_equal 32, stat.l
    end

    def test_maps_min
      stub_pt_stats_request

      stat = LeagueDashPtStats.all(season: 2024).first

      assert_in_delta 32.5, stat.min
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
