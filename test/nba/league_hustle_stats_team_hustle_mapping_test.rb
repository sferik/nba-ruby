require_relative "../test_helper"

module NBA
  class LeagueHustleStatsTeamHustleMappingTest < Minitest::Test
    cover LeagueHustleStatsTeam

    def test_all_sets_contested_shots
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 2856, stats.first.contested_shots
    end

    def test_all_sets_contested_shots_2pt
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 1842, stats.first.contested_shots_2pt
    end

    def test_all_sets_contested_shots_3pt
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 1014, stats.first.contested_shots_3pt
    end

    def test_all_sets_deflections
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 1024, stats.first.deflections
    end

    def test_all_sets_charges_drawn
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 42, stats.first.charges_drawn
    end

    def test_all_sets_screen_assists
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 1856, stats.first.screen_assists
    end

    def test_all_sets_screen_ast_pts
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 3712, stats.first.screen_ast_pts
    end

    def test_all_sets_off_loose_balls_recovered
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 312, stats.first.off_loose_balls_recovered
    end

    def test_all_sets_def_loose_balls_recovered
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 428, stats.first.def_loose_balls_recovered
    end

    def test_all_sets_loose_balls_recovered
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 740, stats.first.loose_balls_recovered
    end

    def test_all_sets_pct_loose_balls_recovered_off
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_in_delta 0.422, stats.first.pct_loose_balls_recovered_off
    end

    def test_all_sets_pct_loose_balls_recovered_def
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_in_delta 0.578, stats.first.pct_loose_balls_recovered_def
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
