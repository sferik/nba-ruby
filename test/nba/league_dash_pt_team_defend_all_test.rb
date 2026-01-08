require_relative "../test_helper"

module NBA
  class LeagueDashPtTeamDefendAllTest < Minitest::Test
    cover LeagueDashPtTeamDefend

    def test_all_returns_collection
      stub_request(:get, /leaguedashptteamdefend/).to_return(body: pt_team_defend_response.to_json)

      assert_instance_of Collection, LeagueDashPtTeamDefend.all(season: 2024)
    end

    def test_all_uses_correct_result_set
      stub_request(:get, /leaguedashptteamdefend/).to_return(body: pt_team_defend_response.to_json)

      result = LeagueDashPtTeamDefend.all(season: 2024)

      assert_equal Team::GSW, result.first.team_id
    end

    def test_all_with_season_type_playoffs
      stub = stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all(season: 2024, season_type: LeagueDashPtTeamDefend::PLAYOFFS)

      assert_requested stub
    end

    def test_all_with_per_mode_totals
      stub = stub_request(:get, /PerMode=Totals/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all(season: 2024, per_mode: LeagueDashPtTeamDefend::TOTALS)

      assert_requested stub
    end

    def test_all_with_defense_category_three_pointers
      stub = stub_request(:get, /DefenseCategory=3%20Pointers/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all(season: 2024, defense_category: LeagueDashPtTeamDefend::THREE_POINTERS)

      assert_requested stub
    end

    def test_all_with_defense_category_two_pointers
      stub = stub_request(:get, /DefenseCategory=2%20Pointers/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all(season: 2024, defense_category: LeagueDashPtTeamDefend::TWO_POINTERS)

      assert_requested stub
    end

    def test_all_with_defense_category_less_than_6ft
      stub = stub_request(:get, /DefenseCategory=Less%20Than%206Ft/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all(season: 2024, defense_category: LeagueDashPtTeamDefend::LESS_THAN_6FT)

      assert_requested stub
    end

    def test_all_with_defense_category_less_than_10ft
      stub = stub_request(:get, /DefenseCategory=Less%20Than%2010Ft/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all(season: 2024, defense_category: LeagueDashPtTeamDefend::LESS_THAN_10FT)

      assert_requested stub
    end

    def test_all_with_defense_category_greater_than_15ft
      stub = stub_request(:get, /DefenseCategory=Greater%20Than%2015Ft/)
        .to_return(body: pt_team_defend_response.to_json)

      LeagueDashPtTeamDefend.all(season: 2024, defense_category: LeagueDashPtTeamDefend::GREATER_THAN_15FT)

      assert_requested stub
    end

    def test_all_with_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, pt_team_defend_response.to_json, [String]

      LeagueDashPtTeamDefend.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def pt_team_defend_response
      {resultSets: [{name: "LeagueDashPtTeamDefend", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION GP G FREQ D_FGM D_FGA D_FG_PCT NORMAL_FG_PCT PCT_PLUSMINUS]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", "GSW", 82, 82, 0.089,
        245.0, 612.0, 0.400, 0.450, -0.050]
    end
  end
end
