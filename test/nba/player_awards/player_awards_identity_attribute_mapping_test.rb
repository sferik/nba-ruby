require_relative "../../test_helper"

module NBA
  class PlayerAwardsIdentityAttributeMappingTest < Minitest::Test
    cover PlayerAwards

    def test_maps_all_identity_attributes
      stub_awards_request

      award = PlayerAwards.find(player: 201_939).first

      assert_equal 201_939, award.player_id
      assert_equal "Stephen", award.first_name
      assert_equal "Curry", award.last_name
      assert_equal "Warriors", award.team
      assert_equal "All-Star", award.description
    end

    private

    def stub_awards_request
      stub_request(:get, /playerawards/).to_return(body: awards_response.to_json)
    end

    def awards_response
      {resultSets: [{
        name: "PlayerAwards",
        headers: %w[FIRST_NAME LAST_NAME TEAM DESCRIPTION ALL_NBA_TEAM_NUMBER SEASON MONTH WEEK CONFERENCE TYPE SUBTYPE1 SUBTYPE2 SUBTYPE3],
        rowSet: [["Stephen", "Curry", "Warriors", "All-Star", 1, "2023-24", 2, 10, "West", "All-Star", "Guard", "Starter", "Captain"]]
      }]}
    end
  end
end
