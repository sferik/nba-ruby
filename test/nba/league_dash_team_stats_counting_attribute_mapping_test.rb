require_relative "../test_helper"

module NBA
  class LeagueDashTeamStatsCountingAttributeMappingTest < Minitest::Test
    cover LeagueDashTeamStats

    def test_maps_oreb
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(10.2, stat.oreb)
    end

    def test_maps_dreb
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(34.5, stat.dreb)
    end

    def test_maps_reb
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(44.7, stat.reb)
    end

    def test_maps_ast
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(27.8, stat.ast)
    end

    def test_maps_tov
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(13.2, stat.tov)
    end

    def test_maps_stl
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(7.5, stat.stl)
    end

    def test_maps_blk
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(5.2, stat.blk)
    end

    def test_maps_blka
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(4.8, stat.blka)
    end

    def test_maps_pf
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(18.5, stat.pf)
    end

    def test_maps_pfd
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(19.2, stat.pfd)
    end

    def test_maps_pts
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(115.8, stat.pts)
    end

    def test_maps_plus_minus
      stub_team_stats_request

      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta(5.2, stat.plus_minus)
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
