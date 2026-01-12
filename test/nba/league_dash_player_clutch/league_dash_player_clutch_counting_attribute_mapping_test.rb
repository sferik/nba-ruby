require_relative "../../test_helper"

module NBA
  class LeagueDashPlayerClutchCountingAttributeMappingTest < Minitest::Test
    cover LeagueDashPlayerClutch

    def test_maps_oreb
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.1, stat.oreb)
    end

    def test_maps_dreb
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.5, stat.dreb)
    end

    def test_maps_reb
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.6, stat.reb)
    end

    def test_maps_ast
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(1.0, stat.ast)
    end

    def test_maps_tov
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.4, stat.tov)
    end

    def test_maps_stl
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.2, stat.stl)
    end

    def test_maps_blk
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.1, stat.blk)
    end

    def test_maps_pf
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(0.3, stat.pf)
    end

    def test_maps_pts
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(3.7, stat.pts)
    end

    def test_maps_plus_minus
      stub_clutch_request

      stat = LeagueDashPlayerClutch.all(season: 2024).first

      assert_in_delta(1.2, stat.plus_minus)
    end

    private

    def stub_clutch_request
      stub_request(:get, /leaguedashplayerclutch/).to_return(body: clutch_response.to_json)
    end

    def clutch_response
      {resultSets: [{name: "LeagueDashPlayerClutch", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE GP W L W_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT
        OREB DREB REB AST TOV STL BLK PF PTS PLUS_MINUS]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36, 74, 46, 28, 0.622, 5.2,
        1.2, 2.8, 0.429, 0.5, 1.4, 0.357, 0.8, 0.9, 0.889,
        0.1, 0.5, 0.6, 1.0, 0.4, 0.2, 0.1, 0.3, 3.7, 1.2]
    end
  end
end
