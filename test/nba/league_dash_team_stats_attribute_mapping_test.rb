require_relative "../test_helper"

module NBA
  class LeagueDashTeamStatsAttributeMappingTest < Minitest::Test
    cover LeagueDashTeamStats

    def test_maps_team_identity_attributes
      stub_stats_request
      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
    end

    def test_maps_record_attributes
      stub_stats_request
      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_equal 82, stat.gp
      assert_equal 46, stat.w
      assert_equal 36, stat.l
      assert_in_delta 0.561, stat.w_pct
    end

    def test_maps_field_goal_attributes
      stub_stats_request
      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta 48.0, stat.min
      assert_in_delta 43.5, stat.fgm
      assert_in_delta 91.0, stat.fga
      assert_in_delta 0.478, stat.fg_pct
    end

    def test_maps_three_point_attributes
      stub_stats_request
      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta 14.2, stat.fg3m
      assert_in_delta 37.5, stat.fg3a
      assert_in_delta 0.378, stat.fg3_pct
    end

    def test_maps_free_throw_attributes
      stub_stats_request
      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta 17.7, stat.ftm
      assert_in_delta 22.1, stat.fta
      assert_in_delta 0.801, stat.ft_pct
    end

    def test_maps_rebound_attributes
      stub_stats_request
      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta 10.2, stat.oreb
      assert_in_delta 34.0, stat.dreb
      assert_in_delta 44.2, stat.reb
    end

    def test_maps_other_counting_attributes
      stub_stats_request
      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta 28.7, stat.ast
      assert_in_delta 14.1, stat.tov
      assert_in_delta 7.8, stat.stl
      assert_in_delta 5.2, stat.blk
      assert_in_delta 4.8, stat.blka
    end

    def test_maps_foul_and_score_attributes
      stub_stats_request
      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_in_delta 19.5, stat.pf
      assert_in_delta 19.2, stat.pfd
      assert_in_delta 118.9, stat.pts
      assert_in_delta 4.5, stat.plus_minus
    end

    def test_maps_rank_attributes
      stub_stats_request
      stat = LeagueDashTeamStats.all(season: 2024).first

      assert_equal 1, stat.gp_rank
      assert_equal 5, stat.w_rank
      assert_equal 3, stat.pts_rank
    end

    private

    def stub_stats_request
      stub_request(:get, /leaguedashteamstats/).to_return(body: stats_response.to_json)
    end

    def stats_response
      {resultSets: [{name: "LeagueDashTeamStats", headers: stats_headers, rowSet: [stats_row]}]}
    end

    def stats_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS
        GP_RANK W_RANK PTS_RANK]
    end

    def stats_row
      [Team::GSW, "Warriors", 82, 46, 36, 0.561, 48.0, 43.5, 91.0, 0.478, 14.2, 37.5, 0.378,
        17.7, 22.1, 0.801, 10.2, 34.0, 44.2, 28.7, 14.1, 7.8, 5.2, 4.8, 19.5, 19.2, 118.9, 4.5,
        1, 5, 3]
    end
  end
end
