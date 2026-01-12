require_relative "../../test_helper"

module NBA
  class LeagueHustleStatsPlayerIdentityMappingTest < Minitest::Test
    cover LeagueHustleStatsPlayer

    def test_all_sets_player_name
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal "Stephen Curry", stats.first.player_name
    end

    def test_all_sets_team_id
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal Team::GSW, stats.first.team_id
    end

    def test_all_sets_team_abbreviation
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal "GSW", stats.first.team_abbreviation
    end

    def test_all_sets_age
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 36, stats.first.age
    end

    def test_all_sets_games_played
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 72, stats.first.g
    end

    def test_all_sets_minutes
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_in_delta 34.5, stats.first.min
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
