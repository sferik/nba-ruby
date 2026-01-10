require_relative "../test_helper"

module NBA
  class LeagueHustleStatsTeamBoxOutMappingTest < Minitest::Test
    cover LeagueHustleStatsTeam

    def test_all_sets_off_boxouts
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 245, stats.first.off_boxouts
    end

    def test_all_sets_def_boxouts
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 1256, stats.first.def_boxouts
    end

    def test_all_sets_box_outs
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 1501, stats.first.box_outs
    end

    def test_all_sets_pct_box_outs_off
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_in_delta 0.163, stats.first.pct_box_outs_off
    end

    def test_all_sets_pct_box_outs_def
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_in_delta 0.837, stats.first.pct_box_outs_def
    end

    private

    def stub_hustle_stats_request
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: hustle_stats_response.to_json)
    end

    def hustle_stats_response
      {resultSets: [{name: "HustleStatsTeam", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME MIN
        CONTESTED_SHOTS CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT
        DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS SCREEN_AST_PTS
        OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED LOOSE_BALLS_RECOVERED
        PCT_LOOSE_BALLS_RECOVERED_OFF PCT_LOOSE_BALLS_RECOVERED_DEF
        OFF_BOXOUTS DEF_BOXOUTS BOX_OUTS
        PCT_BOX_OUTS_OFF PCT_BOX_OUTS_DEF]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", 19_680.5,
        2856, 1842, 1014,
        1024, 42, 1856, 3712,
        312, 428, 740,
        0.422, 0.578,
        245, 1256, 1501,
        0.163, 0.837]
    end
  end
end
