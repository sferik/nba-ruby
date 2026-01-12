require_relative "../../test_helper"

module NBA
  class LeagueHustleStatsTeamIdentityMappingTest < Minitest::Test
    cover LeagueHustleStatsTeam

    def test_all_sets_team_id
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal Team::GSW, stats.first.team_id
    end

    def test_all_sets_team_name
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_equal "Golden State Warriors", stats.first.team_name
    end

    def test_all_sets_minutes
      stub_hustle_stats_request

      stats = LeagueHustleStatsTeam.all(season: 2024)

      assert_in_delta 19_680.5, stats.first.min
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
