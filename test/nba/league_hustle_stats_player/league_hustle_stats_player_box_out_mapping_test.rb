require_relative "../../test_helper"

module NBA
  class LeagueHustleStatsPlayerBoxOutMappingTest < Minitest::Test
    cover LeagueHustleStatsPlayer

    def test_all_sets_off_boxouts
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 12, stats.first.off_boxouts
    end

    def test_all_sets_def_boxouts
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 45, stats.first.def_boxouts
    end

    def test_all_sets_box_out_player_team_rebs
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 38, stats.first.box_out_player_team_rebs
    end

    def test_all_sets_box_out_player_rebs
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 22, stats.first.box_out_player_rebs
    end

    def test_all_sets_box_outs
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 57, stats.first.box_outs
    end

    def test_all_sets_pct_box_outs_off
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_in_delta 0.211, stats.first.pct_box_outs_off
    end

    def test_all_sets_pct_box_outs_def
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_in_delta 0.789, stats.first.pct_box_outs_def
    end

    def test_all_sets_pct_box_outs_team_reb
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_in_delta 0.667, stats.first.pct_box_outs_team_reb
    end

    def test_all_sets_pct_box_outs_reb
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_in_delta 0.386, stats.first.pct_box_outs_reb
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
