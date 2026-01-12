require_relative "../../test_helper"

module NBA
  class LeagueDashTeamStatsIdentityAttributeMappingTest < Minitest::Test
    cover LeagueDashTeamStats

    def test_maps_team_id
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_equal Team::GSW, stat.team_id
    end

    def test_maps_team_name
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_equal "Golden State Warriors", stat.team_name
    end

    def test_maps_season_id
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_equal "2024-25", stat.season_id
    end

    def test_maps_gp
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_equal 82, stat.gp
    end

    def test_maps_w
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_equal 53, stat.w
    end

    def test_maps_l
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_equal 29, stat.l
    end

    def test_maps_w_pct
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(0.646, stat.w_pct)
    end

    def test_maps_min
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(240.0, stat.min)
    end

    private

    def stub_team_stats_request
      stub_request(:get, /leaguedashteamstats/).to_return(body: team_stats_response.to_json)
    end

    def team_stats_response
      {resultSets: [{name: "LeagueDashTeamStats", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS GP_RANK W_RANK PTS_RANK]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", 82, 53, 29, 0.646, 240.0, 42.3, 90.5, 0.467, 13.7, 38.2, 0.359,
        17.5, 22.3, 0.785, 10.2, 34.5, 44.7, 27.8, 13.2, 7.5, 5.2, 4.8, 18.5, 19.2, 115.8, 5.2, 1, 3, 5]
    end
  end
end
