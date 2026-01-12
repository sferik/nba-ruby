require_relative "../../test_helper"

module NBA
  class LeagueDashLineupsRecordMappingTest < Minitest::Test
    cover LeagueDashLineups

    def test_maps_gp
      stub_lineups_request

      assert_equal 45, stat.gp
    end

    def test_maps_w
      stub_lineups_request

      assert_equal 30, stat.w
    end

    def test_maps_l
      stub_lineups_request

      assert_equal 15, stat.l
    end

    def test_maps_w_pct
      stub_lineups_request

      assert_in_delta 0.667, stat.w_pct
    end

    def test_maps_min
      stub_lineups_request

      assert_in_delta 245.5, stat.min
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
