require_relative "../../test_helper"

module NBA
  class TeamHistoricalLeadersTest < Minitest::Test
    cover TeamHistoricalLeaders

    def test_find_returns_team_historical_leader
      stub_request(:get, /teamhistoricalleaders/).to_return(body: leaders_response.to_json)

      result = TeamHistoricalLeaders.find(team: 1_610_612_744)

      assert_instance_of TeamHistoricalLeader, result
    end

    def test_find_returns_nil_when_team_is_nil
      result = TeamHistoricalLeaders.find(team: nil)

      assert_nil result
    end

    def test_find_extracts_id_from_team_object
      stub_request(:get, /TeamID=1610612744/).to_return(body: leaders_response.to_json)
      team = Team.new(id: 1_610_612_744)

      TeamHistoricalLeaders.find(team: team)

      assert_requested :get, /TeamID=1610612744/
    end

    def test_find_uses_current_season_by_default
      expected_season = Utils.format_season_id(Utils.current_season)
      stub_request(:get, /SeasonID=#{expected_season}/).to_return(body: leaders_response.to_json)

      TeamHistoricalLeaders.find(team: 1_610_612_744)

      assert_requested :get, /SeasonID=#{expected_season}/
    end

    def test_find_uses_provided_season
      stub_request(:get, /SeasonID=22023/).to_return(body: leaders_response.to_json)

      TeamHistoricalLeaders.find(team: 1_610_612_744, season: 2023)

      assert_requested :get, /SeasonID=22023/
    end

    def test_result_set_name_constant
      assert_equal "CareerLeadersByTeam", TeamHistoricalLeaders::RESULT_SET_NAME
    end

    def test_find_uses_correct_result_set
      response_with_multiple_sets = {
        resultSets: [
          {name: "OtherSet", headers: %w[ID], rowSet: [[999]]},
          {name: "CareerLeadersByTeam", headers: leaders_headers, rowSet: [leaders_row]}
        ]
      }
      stub_request(:get, /teamhistoricalleaders/).to_return(body: response_with_multiple_sets.to_json)

      leader = TeamHistoricalLeaders.find(team: 1_610_612_744)

      assert_equal 1_610_612_744, leader.team_id
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
        4_874, 201_142, "Kevin Durant", 986, 201_142, "Andrew Bogut", 1_594, 201_939, "Stephen Curry"]
    end
  end
end
