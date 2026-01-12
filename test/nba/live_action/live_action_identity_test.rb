require_relative "../../test_helper"

module NBA
  class LiveActionIdentityTest < Minitest::Test
    cover LiveAction

    def test_equality_based_on_action_number_and_game_id
      action1 = LiveAction.new(action_number: 1, game_id: "0022400001")
      action2 = LiveAction.new(action_number: 1, game_id: "0022400001")
      action3 = LiveAction.new(action_number: 2, game_id: "0022400001")
      action4 = LiveAction.new(action_number: 1, game_id: "0022400002")

      assert_equal action1, action2
      refute_equal action1, action3
      refute_equal action1, action4
    end

    def test_player_returns_player_object_when_player_id_present
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/)
        .to_return(body: player_info_response.to_json)
      action = LiveAction.new(player_id: 201_939)

      assert_equal 201_939, action.player.id
    end

    def test_player_returns_nil_when_player_id_nil
      action = LiveAction.new(player_id: nil)

      assert_nil action.player
      assert_not_requested :get, /commonplayerinfo/
    end

    def test_team_returns_team_object_when_team_id_present
      action = LiveAction.new(team_id: Team::GSW)

      assert_equal Team::GSW, action.team.id
    end

    def test_team_returns_nil_when_team_id_nil
      action = LiveAction.new(team_id: nil)

      assert_nil action.team
    end

    def test_field_goal_returns_true_when_is_field_goal_is_one
      action = LiveAction.new(is_field_goal: 1)

      assert_predicate action, :field_goal?
    end

    def test_field_goal_returns_false_when_is_field_goal_is_zero
      action = LiveAction.new(is_field_goal: 0)

      refute_predicate action, :field_goal?
    end

    def test_made_returns_true_when_shot_result_is_made
      action = LiveAction.new(shot_result: "Made")

      assert_predicate action, :made?
      refute_predicate action, :missed?
    end

    def test_missed_returns_true_when_shot_result_is_missed
      action = LiveAction.new(shot_result: "Missed")

      assert_predicate action, :missed?
      refute_predicate action, :made?
    end

    def test_qualifiers_is_a_collection
      action = LiveAction.new(qualifiers: %w[fastbreak pointsinthepaint])

      assert_equal %w[fastbreak pointsinthepaint], action.qualifiers
    end

    private

    def player_info_response
      {resultSets: [{name: "CommonPlayerInfo",
                     headers: %w[PERSON_ID DISPLAY_FIRST_LAST TEAM_ID],
                     rowSet: [[201_939, "Stephen Curry", 1_610_612_744]]}]}
    end
  end
end
