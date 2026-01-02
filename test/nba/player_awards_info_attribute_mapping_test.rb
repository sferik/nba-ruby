require_relative "../test_helper"

module NBA
  class PlayerAwardsInfoAttributeMappingTest < Minitest::Test
    cover PlayerAwards

    def test_maps_team_and_season_attributes
      stub_awards_request

      award = PlayerAwards.find(player: 201_939).first

      assert_equal 1, award.all_nba_team_number
      assert_equal "2023-24", award.season
      assert_equal 2, award.month
      assert_equal 10, award.week
      assert_equal "West", award.conference
    end

    def test_maps_award_type_attributes
      stub_awards_request

      award = PlayerAwards.find(player: 201_939).first

      assert_equal "All-Star", award.award_type
      assert_equal "Guard", award.subtype1
      assert_equal "Starter", award.subtype2
      assert_equal "Captain", award.subtype3
    end

    private

    def stub_awards_request
      stub_request(:get, /playerawards/).to_return(body: awards_response.to_json)
    end

    def awards_response
      headers = %w[FIRST_NAME LAST_NAME TEAM DESCRIPTION ALL_NBA_TEAM_NUMBER
        SEASON MONTH WEEK CONFERENCE TYPE SUBTYPE1 SUBTYPE2 SUBTYPE3]
      row = ["Stephen", "Curry", "Warriors", "All-Star", 1, "2023-24", 2, 10, "West", "All-Star", "Guard", "Starter", "Captain"]
      {resultSets: [{name: "PlayerAwards", headers: headers, rowSet: [row]}]}
    end
  end
end
