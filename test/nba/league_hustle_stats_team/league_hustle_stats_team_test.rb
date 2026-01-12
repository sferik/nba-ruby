require_relative "../../test_helper"

module NBA
  class LeagueHustleStatsTeamTest < Minitest::Test
    cover LeagueHustleStatsTeam

    def test_all_returns_collection
      stub_hustle_stats_request

      result = LeagueHustleStatsTeam.all(season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_hustle_stats_request

      LeagueHustleStatsTeam.all(season: 2024)

      assert_requested :get, /leaguehustlestatsteam.*Season=2024-25/
    end

    def test_all_uses_correct_season_type_in_path
      stub_hustle_stats_request

      LeagueHustleStatsTeam.all(season: 2024, season_type: LeagueHustleStatsTeam::PLAYOFFS)

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_all_uses_correct_per_mode_in_path
      stub_hustle_stats_request

      LeagueHustleStatsTeam.all(season: 2024, per_mode: LeagueHustleStatsTeam::TOTALS)

      assert_requested :get, /PerMode=Totals/
    end

    def test_all_parses_stats_successfully
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, hustle_stats_response.to_json, [String]

      LeagueHustleStatsTeam.all(season: 2024, client: mock_client)

      mock_client.verify
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
