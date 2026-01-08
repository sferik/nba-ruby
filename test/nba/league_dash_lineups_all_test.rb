require_relative "../test_helper"

module NBA
  class LeagueDashLineupsAllTest < Minitest::Test
    cover LeagueDashLineups

    def test_all_returns_collection
      stub_request(:get, /leaguedashlineups/).to_return(body: lineups_response.to_json)

      assert_instance_of Collection, LeagueDashLineups.all(season: 2024)
    end

    def test_all_uses_correct_result_set
      stub_request(:get, /leaguedashlineups/).to_return(body: lineups_response.to_json)

      result = LeagueDashLineups.all(season: 2024)

      assert_equal "201939-203110", result.first.group_id
    end

    def test_all_with_season_type_parameter
      stub = stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: lineups_response.to_json)

      LeagueDashLineups.all(season: 2024, season_type: LeagueDashLineups::PLAYOFFS)

      assert_requested stub
    end

    def test_all_with_per_mode_parameter
      stub = stub_request(:get, /PerMode=Totals/)
        .to_return(body: lineups_response.to_json)

      LeagueDashLineups.all(season: 2024, per_mode: LeagueDashLineups::TOTALS)

      assert_requested stub
    end

    def test_all_with_group_quantity_parameter
      stub = stub_request(:get, /GroupQuantity=3/)
        .to_return(body: lineups_response.to_json)

      LeagueDashLineups.all(season: 2024, group_quantity: LeagueDashLineups::THREE_MAN)

      assert_requested stub
    end

    def test_all_with_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, lineups_response.to_json, [String]

      LeagueDashLineups.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

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
