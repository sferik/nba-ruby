require_relative "../test_helper"

module NBA
  class LiveActionAttributesTest < Minitest::Test
    cover LiveAction

    def test_identity_attributes
      action = sample_action

      assert_equal "0022400001", action.game_id
      assert_equal 42, action.action_number
      assert_equal 201_939, action.player_id
      assert_equal Team::GSW, action.team_id
      assert_equal "GSW", action.team_tricode
    end

    def test_timing_attributes
      action = sample_action

      assert_equal "PT10M30.00S", action.clock
      assert_equal "2024-10-22T23:45:30Z", action.time_actual
      assert_equal 1, action.period
      assert_equal "REGULAR", action.period_type
    end

    def test_action_attributes
      action = sample_action

      assert_equal "3pt", action.action_type
      assert_equal "jumpshot", action.sub_type
      assert_equal ["fastbreak"], action.qualifiers
      assert_equal "Curry 26' 3PT (3 PTS)", action.description
    end

    def test_scoring_attributes
      action = sample_action

      assert_equal "3", action.score_home
      assert_equal "0", action.score_away
      assert_equal 3, action.points_total
      assert_equal "Made", action.shot_result
    end

    def test_shot_location
      action = sample_action

      assert_in_delta 23.5, action.x_legacy
      assert_in_delta 12.0, action.y_legacy
      assert_in_delta 26.0, action.shot_distance
      assert_equal 1, action.is_field_goal
    end

    private

    def sample_action
      LiveAction.new(
        game_id: "0022400001", action_number: 42, clock: "PT10M30.00S",
        time_actual: "2024-10-22T23:45:30Z", period: 1, period_type: "REGULAR",
        action_type: "3pt", sub_type: "jumpshot", qualifiers: ["fastbreak"],
        description: "Curry 26' 3PT (3 PTS)", player_id: 201_939,
        player_name: "Stephen Curry", player_name_i: "S. Curry", team_id: Team::GSW,
        team_tricode: "GSW", score_home: "3", score_away: "0", points_total: 3,
        x_legacy: 23.5, y_legacy: 12.0, shot_distance: 26.0, is_field_goal: 1,
        shot_result: "Made"
      )
    end
  end
end
