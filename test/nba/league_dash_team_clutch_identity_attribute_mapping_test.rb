require_relative "../test_helper"

module NBA
  class LeagueDashTeamClutchIdentityAttributeMappingTest < Minitest::Test
    cover LeagueDashTeamClutch

    def test_maps_team_id
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_equal Team::GSW, stat.team_id
    end

    def test_maps_team_name
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_equal "Golden State Warriors", stat.team_name
    end

    def test_maps_season_id
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_equal "2024-25", stat.season_id
    end

    def test_maps_gp
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_equal 82, stat.gp
    end

    def test_maps_w
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_equal 46, stat.w
    end

    def test_maps_l
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_equal 36, stat.l
    end

    def test_maps_w_pct
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(0.561, stat.w_pct)
    end

    def test_maps_min
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(5.0, stat.min)
    end

    private

    def stub_clutch_request
      stub_request(:get, /leaguedashteamclutch/).to_return(body: clutch_response.to_json)
    end

    def clutch_response
      {resultSets: [{name: "LeagueDashTeamClutch", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME GP W L W_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK PF PTS PLUS_MINUS]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", 82, 46, 36, 0.561, 5.0, 3.2, 7.5, 0.427, 1.2, 3.5, 0.343,
        2.0, 2.5, 0.800, 0.8, 2.2, 3.0, 1.8, 1.2, 0.6, 0.3, 1.5, 9.6, 0.8]
    end
  end
end
