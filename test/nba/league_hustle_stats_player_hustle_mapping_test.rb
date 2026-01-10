require_relative "../test_helper"

module NBA
  class LeagueHustleStatsPlayerHustleMappingTest < Minitest::Test
    cover LeagueHustleStatsPlayer

    def test_all_sets_contested_shots
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 156, stats.first.contested_shots
    end

    def test_all_sets_contested_shots_2pt
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 98, stats.first.contested_shots_2pt
    end

    def test_all_sets_contested_shots_3pt
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 58, stats.first.contested_shots_3pt
    end

    def test_all_sets_deflections
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 85, stats.first.deflections
    end

    def test_all_sets_charges_drawn
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 5, stats.first.charges_drawn
    end

    def test_all_sets_screen_assists
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 142, stats.first.screen_assists
    end

    def test_all_sets_screen_ast_pts
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 284, stats.first.screen_ast_pts
    end

    def test_all_sets_off_loose_balls_recovered
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 25, stats.first.off_loose_balls_recovered
    end

    def test_all_sets_def_loose_balls_recovered
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 35, stats.first.def_loose_balls_recovered
    end

    def test_all_sets_loose_balls_recovered
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 60, stats.first.loose_balls_recovered
    end

    def test_all_sets_pct_loose_balls_recovered_off
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_in_delta 0.417, stats.first.pct_loose_balls_recovered_off
    end

    def test_all_sets_pct_loose_balls_recovered_def
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_in_delta 0.583, stats.first.pct_loose_balls_recovered_def
    end

    private

    def stub_hustle_stats_request
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: hustle_stats_response.to_json)
    end

    def hustle_stats_response
      {resultSets: [{name: "HustleStatsPlayer", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE G MIN
        CONTESTED_SHOTS CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT
        DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS SCREEN_AST_PTS
        OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED LOOSE_BALLS_RECOVERED
        PCT_LOOSE_BALLS_RECOVERED_OFF PCT_LOOSE_BALLS_RECOVERED_DEF
        OFF_BOXOUTS DEF_BOXOUTS BOX_OUT_PLAYER_TEAM_REBS BOX_OUT_PLAYER_REBS BOX_OUTS
        PCT_BOX_OUTS_OFF PCT_BOX_OUTS_DEF PCT_BOX_OUTS_TEAM_REB PCT_BOX_OUTS_REB]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36, 72, 34.5,
        156, 98, 58,
        85, 5, 142, 284,
        25, 35, 60,
        0.417, 0.583,
        12, 45, 38, 22, 57,
        0.211, 0.789, 0.667, 0.386]
    end
  end
end
