require_relative "../test_helper"

module NBA
  class TeamHistoricalLeadersStlValuesTest < Minitest::Test
    cover TeamHistoricalLeaders

    def test_extracts_stl
      stub_request(:get, /teamhistoricalleaders/).to_return(body: leaders_response.to_json)

      leader = TeamHistoricalLeaders.find(team: 1_610_612_744)

      assert_equal 1_594, leader.stl
    end

    def test_extracts_stl_person_id
      stub_request(:get, /teamhistoricalleaders/).to_return(body: leaders_response.to_json)

      leader = TeamHistoricalLeaders.find(team: 1_610_612_744)

      assert_equal 201_939, leader.stl_person_id
    end

    def test_extracts_stl_player
      stub_request(:get, /teamhistoricalleaders/).to_return(body: leaders_response.to_json)

      leader = TeamHistoricalLeaders.find(team: 1_610_612_744)

      assert_equal "Stephen Curry", leader.stl_player
    end

    private

    def leaders_response
      {resultSets: [{name: "CareerLeadersByTeam", headers: leaders_headers, rowSet: [leaders_row]}]}
    end

    def leaders_headers
      %w[TEAM_ID SEASON_YEAR PTS PTS_PERSON_ID PTS_PLAYER AST AST_PERSON_ID AST_PLAYER
        REB REB_PERSON_ID REB_PLAYER BLK BLK_PERSON_ID BLK_PLAYER STL STL_PERSON_ID STL_PLAYER]
    end

    def leaders_row
      [1_610_612_744, 2024, 23_788, 201_939, "Stephen Curry", 6_475, 201_939, "Stephen Curry",
        4_874, 201_142, "Kevin Durant", 986, 101_106, "Andrew Bogut", 1_594, 201_939, "Stephen Curry"]
    end
  end
end
