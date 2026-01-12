require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerBioStatsStatMappingTest < Minitest::Test
    cover LeagueDashPlayerBioStats

    def test_maps_gp
      stub_bio_stats_request

      assert_equal 74, stat.gp
    end

    def test_maps_pts
      stub_bio_stats_request

      assert_in_delta 26.4, stat.pts
    end

    def test_maps_reb
      stub_bio_stats_request

      assert_in_delta 5.2, stat.reb
    end

    def test_maps_ast
      stub_bio_stats_request

      assert_in_delta 6.1, stat.ast
    end

    def test_maps_net_rating
      stub_bio_stats_request

      assert_in_delta 8.5, stat.net_rating
    end

    def test_maps_oreb_pct
      stub_bio_stats_request

      assert_in_delta 0.025, stat.oreb_pct
    end

    def test_maps_dreb_pct
      stub_bio_stats_request

      assert_in_delta 0.112, stat.dreb_pct
    end

    def test_maps_usg_pct
      stub_bio_stats_request

      assert_in_delta 0.298, stat.usg_pct
    end

    def test_maps_ts_pct
      stub_bio_stats_request

      assert_in_delta 0.621, stat.ts_pct
    end

    def test_maps_ast_pct
      stub_bio_stats_request

      assert_in_delta 0.312, stat.ast_pct
    end

    private

    def stat
      LeagueDashPlayerBioStats.all(season: 2024).first
    end

    def stub_bio_stats_request
      stub_request(:get, /leaguedashplayerbiostats/).to_return(body: bio_stats_response.to_json)
    end

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
