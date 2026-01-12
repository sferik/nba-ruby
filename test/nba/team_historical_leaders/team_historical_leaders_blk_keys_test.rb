require_relative "../../test_helper"

module NBA
  class TeamHistoricalLeadersBlkKeysTest < Minitest::Test
    cover TeamHistoricalLeaders

    def test_handles_missing_blk_key
      stub_request(:get, /teamhistoricalleaders/).to_return(body: response_missing_key("BLK").to_json)

      leader = TeamHistoricalLeaders.find(team: 1_610_612_744)

      assert_nil leader.blk
    end

    def test_handles_missing_blk_person_id_key
      stub_request(:get, /teamhistoricalleaders/).to_return(body: response_missing_key("BLK_PERSON_ID").to_json)

      leader = TeamHistoricalLeaders.find(team: 1_610_612_744)

      assert_nil leader.blk_person_id
    end

    def test_handles_missing_blk_player_key
      stub_request(:get, /teamhistoricalleaders/).to_return(body: response_missing_key("BLK_PLAYER").to_json)

      leader = TeamHistoricalLeaders.find(team: 1_610_612_744)

      assert_nil leader.blk_player
    end

    private

    def response_missing_key(key)
      headers = leaders_headers.reject { |h| h == key }
      row = leaders_row.each_with_index.reject { |_, i| leaders_headers[i] == key }.map(&:first)
      {resultSets: [{name: "CareerLeadersByTeam", headers: headers, rowSet: [row]}]}
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
