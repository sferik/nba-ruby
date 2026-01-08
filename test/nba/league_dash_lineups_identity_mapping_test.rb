require_relative "../test_helper"

module NBA
  class LeagueDashLineupsIdentityMappingTest < Minitest::Test
    cover LeagueDashLineups

    def test_maps_group_set
      stub_lineups_request

      assert_equal "5 Man Lineups", stat.group_set
    end

    def test_maps_group_id
      stub_lineups_request

      assert_equal "201939-203110", stat.group_id
    end

    def test_maps_group_name
      stub_lineups_request

      assert_equal "S. Curry - K. Thompson", stat.group_name
    end

    def test_maps_team_id
      stub_lineups_request

      assert_equal Team::GSW, stat.team_id
    end

    def test_maps_team_abbreviation
      stub_lineups_request

      assert_equal "GSW", stat.team_abbreviation
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
