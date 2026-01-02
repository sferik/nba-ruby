require_relative "../test_helper"

module NBA
  class AllTimeLeaderModelTest < Minitest::Test
    cover AllTimeLeader

    def test_objects_with_same_player_id_and_category_are_equal
      leader0 = AllTimeLeader.new(player_id: 2544, category: "PTS")
      leader1 = AllTimeLeader.new(player_id: 2544, category: "PTS")

      assert_equal leader0, leader1
    end

    def test_objects_with_different_player_id_are_not_equal
      leader0 = AllTimeLeader.new(player_id: 2544, category: "PTS")
      leader1 = AllTimeLeader.new(player_id: 201_939, category: "PTS")

      refute_equal leader0, leader1
    end

    def test_objects_with_different_category_are_not_equal
      leader0 = AllTimeLeader.new(player_id: 2544, category: "PTS")
      leader1 = AllTimeLeader.new(player_id: 2544, category: "REB")

      refute_equal leader0, leader1
    end

    def test_player_returns_nil_when_player_id_is_nil
      leader = AllTimeLeader.new(player_id: nil)

      assert_nil leader.player
    end

    def test_player_returns_player_object_when_player_id_valid
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)

      leader = AllTimeLeader.new(player_id: 2544)
      result = leader.player

      assert_instance_of Player, result
      assert_equal 2544, result.id
    end

    def test_active_returns_true_when_is_active_true
      leader = AllTimeLeader.new(is_active: true)

      assert_predicate leader, :active?
    end

    def test_active_returns_false_when_is_active_false
      leader = AllTimeLeader.new(is_active: false)

      refute_predicate leader, :active?
    end

    def test_active_returns_false_when_is_active_nil
      leader = AllTimeLeader.new(is_active: nil)

      refute_predicate leader, :active?
    end

    private

    def player_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME]
      row = [2544, "LeBron James", "LeBron", "James"]
      {resultSets: [{name: "CommonPlayerInfo", headers: headers, rowSet: [row]}]}
    end
  end
end
