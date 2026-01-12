require_relative "../../test_helper"

module NBA
  class LeagueDashLineupsCountingMappingTest < Minitest::Test
    cover LeagueDashLineups

    def test_maps_oreb
      stub_lineups_request

      assert_in_delta 1.8, stat.oreb
    end

    def test_maps_dreb
      stub_lineups_request

      assert_in_delta 6.2, stat.dreb
    end

    def test_maps_reb
      stub_lineups_request

      assert_in_delta 8.0, stat.reb
    end

    def test_maps_ast
      stub_lineups_request

      assert_in_delta 5.5, stat.ast
    end

    def test_maps_tov
      stub_lineups_request

      assert_in_delta 2.1, stat.tov
    end

    def test_maps_stl
      stub_lineups_request

      assert_in_delta 1.5, stat.stl
    end

    def test_maps_blk
      stub_lineups_request

      assert_in_delta 0.8, stat.blk
    end

    def test_maps_blka
      stub_lineups_request

      assert_in_delta 0.5, stat.blka
    end

    def test_maps_pf
      stub_lineups_request

      assert_in_delta 2.3, stat.pf
    end

    def test_maps_pfd
      stub_lineups_request

      assert_in_delta 3.1, stat.pfd
    end

    def test_maps_pts
      stub_lineups_request

      assert_in_delta 23.3, stat.pts
    end

    def test_maps_plus_minus
      stub_lineups_request

      assert_in_delta 8.5, stat.plus_minus
    end

    private

    def stat
      LeagueDashLineups.all(season: 2024).first
    end

    def stub_lineups_request
      stub_request(:get, /leaguedashlineups/).to_return(body: lineups_response.to_json)
    end

    def lineups_response
      {resultSets: [{name: "Lineups", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[GROUP_SET GROUP_ID GROUP_NAME TEAM_ID TEAM_ABBREVIATION GP W L W_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST TOV STL
        BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def stat_row
      ["5 Man Lineups", "201939-203110", "S. Curry - K. Thompson", Team::GSW, "GSW", 45, 30, 15, 0.667, 245.5,
        8.5, 17.2, 0.494, 3.2, 8.5, 0.376, 3.1, 3.8, 0.816, 1.8, 6.2, 8.0, 5.5, 2.1, 1.5,
        0.8, 0.5, 2.3, 3.1, 23.3, 8.5]
    end
  end
end
