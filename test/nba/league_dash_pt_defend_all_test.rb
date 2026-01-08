require_relative "../test_helper"

module NBA
  class LeagueDashPtDefendAllTest < Minitest::Test
    cover LeagueDashPtDefend

    def test_all_returns_collection
      stub_request(:get, /leaguedashptdefend/).to_return(body: pt_defend_response.to_json)

      assert_instance_of Collection, LeagueDashPtDefend.all(season: 2024)
    end

    def test_all_uses_correct_result_set
      stub_request(:get, /leaguedashptdefend/).to_return(body: pt_defend_response.to_json)

      result = LeagueDashPtDefend.all(season: 2024)

      assert_equal 201_939, result.first.player_id
    end

    def test_all_with_season_type_playoffs
      stub = stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: pt_defend_response.to_json)

      LeagueDashPtDefend.all(season: 2024, season_type: LeagueDashPtDefend::PLAYOFFS)

      assert_requested stub
    end

    def test_all_with_per_mode_totals
      stub = stub_request(:get, /PerMode=Totals/)
        .to_return(body: pt_defend_response.to_json)

      LeagueDashPtDefend.all(season: 2024, per_mode: LeagueDashPtDefend::TOTALS)

      assert_requested stub
    end

    def test_all_with_defense_category_three_pointers
      stub = stub_request(:get, /DefenseCategory=3%20Pointers/)
        .to_return(body: pt_defend_response.to_json)

      LeagueDashPtDefend.all(season: 2024, defense_category: LeagueDashPtDefend::THREE_POINTERS)

      assert_requested stub
    end

    def test_all_with_defense_category_two_pointers
      stub = stub_request(:get, /DefenseCategory=2%20Pointers/)
        .to_return(body: pt_defend_response.to_json)

      LeagueDashPtDefend.all(season: 2024, defense_category: LeagueDashPtDefend::TWO_POINTERS)

      assert_requested stub
    end

    def test_all_with_defense_category_less_than_6ft
      stub = stub_request(:get, /DefenseCategory=Less%20Than%206Ft/)
        .to_return(body: pt_defend_response.to_json)

      LeagueDashPtDefend.all(season: 2024, defense_category: LeagueDashPtDefend::LESS_THAN_6FT)

      assert_requested stub
    end

    def test_all_with_defense_category_less_than_10ft
      stub = stub_request(:get, /DefenseCategory=Less%20Than%2010Ft/)
        .to_return(body: pt_defend_response.to_json)

      LeagueDashPtDefend.all(season: 2024, defense_category: LeagueDashPtDefend::LESS_THAN_10FT)

      assert_requested stub
    end

    def test_all_with_defense_category_greater_than_15ft
      stub = stub_request(:get, /DefenseCategory=Greater%20Than%2015Ft/)
        .to_return(body: pt_defend_response.to_json)

      LeagueDashPtDefend.all(season: 2024, defense_category: LeagueDashPtDefend::GREATER_THAN_15FT)

      assert_requested stub
    end

    def test_all_with_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, pt_defend_response.to_json, [String]

      LeagueDashPtDefend.all(season: 2024, client: mock_client)

      mock_client.verify
    end

    private

    def pt_defend_response
      {resultSets: [{name: "LeagueDashPTDefend", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[CLOSE_DEF_PERSON_ID PLAYER_NAME PLAYER_LAST_TEAM_ID PLAYER_LAST_TEAM_ABBREVIATION
        PLAYER_POSITION AGE GP G FREQ D_FGM D_FGA D_FG_PCT NORMAL_FG_PCT PCT_PLUSMINUS]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", "G", 36.0, 82, 82, 0.089,
        245.0, 612.0, 0.400, 0.450, -0.050]
    end
  end
end
