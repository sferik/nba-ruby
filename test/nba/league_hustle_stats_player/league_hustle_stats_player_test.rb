require_relative "../../test_helper"

module NBA
  class LeagueHustleStatsPlayerTest < Minitest::Test
    cover LeagueHustleStatsPlayer

    def test_all_returns_collection
      stub_hustle_stats_request

      result = LeagueHustleStatsPlayer.all(season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_hustle_stats_request

      LeagueHustleStatsPlayer.all(season: 2024)

      assert_requested :get, /leaguehustlestatsplayer.*Season=2024-25/
    end

    def test_all_uses_correct_season_type_in_path
      stub_hustle_stats_request

      LeagueHustleStatsPlayer.all(season: 2024, season_type: LeagueHustleStatsPlayer::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_uses_correct_per_mode_in_path
      stub_hustle_stats_request

      LeagueHustleStatsPlayer.all(season: 2024, per_mode: LeagueHustleStatsPlayer::TOTALS)

      assert_requested :get, /PerMode=Totals/
    end

    def test_all_parses_stats_successfully
      stub_hustle_stats_request

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, hustle_stats_response.to_json, [String]

      LeagueHustleStatsPlayer.all(season: 2024, client: mock_client)

      mock_client.verify
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
