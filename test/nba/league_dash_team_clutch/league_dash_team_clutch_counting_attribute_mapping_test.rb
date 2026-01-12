require_relative "../../test_helper"

module NBA
  class LeagueDashTeamClutchCountingAttributeMappingTest < Minitest::Test
    cover LeagueDashTeamClutch

    def test_maps_oreb
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(0.8, stat.oreb)
    end

    def test_maps_dreb
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(2.2, stat.dreb)
    end

    def test_maps_reb
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(3.0, stat.reb)
    end

    def test_maps_ast
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(1.8, stat.ast)
    end

    def test_maps_tov
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(1.2, stat.tov)
    end

    def test_maps_stl
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(0.6, stat.stl)
    end

    def test_maps_blk
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(0.3, stat.blk)
    end

    def test_maps_pf
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(1.5, stat.pf)
    end

    def test_maps_pts
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(9.6, stat.pts)
    end

    def test_maps_plus_minus
      stub_clutch_request

      stat = LeagueDashTeamClutch.all(season: 2024).first

      assert_in_delta(0.8, stat.plus_minus)
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
