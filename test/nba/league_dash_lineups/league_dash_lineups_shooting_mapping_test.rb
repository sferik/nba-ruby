require_relative "../../test_helper"

module NBA
  class LeagueDashLineupsShootingMappingTest < Minitest::Test
    cover LeagueDashLineups

    def test_maps_fgm
      stub_lineups_request

      assert_in_delta 8.5, stat.fgm
    end

    def test_maps_fga
      stub_lineups_request

      assert_in_delta 17.2, stat.fga
    end

    def test_maps_fg_pct
      stub_lineups_request

      assert_in_delta 0.494, stat.fg_pct
    end

    def test_maps_fg3m
      stub_lineups_request

      assert_in_delta 3.2, stat.fg3m
    end

    def test_maps_fg3a
      stub_lineups_request

      assert_in_delta 8.5, stat.fg3a
    end

    def test_maps_fg3_pct
      stub_lineups_request

      assert_in_delta 0.376, stat.fg3_pct
    end

    def test_maps_ftm
      stub_lineups_request

      assert_in_delta 3.1, stat.ftm
    end

    def test_maps_fta
      stub_lineups_request

      assert_in_delta 3.8, stat.fta
    end

    def test_maps_ft_pct
      stub_lineups_request

      assert_in_delta 0.816, stat.ft_pct
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
