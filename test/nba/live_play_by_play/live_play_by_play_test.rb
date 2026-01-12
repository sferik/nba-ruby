require_relative "../../test_helper"

module NBA
  class LivePlayByPlayTest < Minitest::Test
    cover LivePlayByPlay

    def test_find_returns_collection
      stub_live_pbp_request

      assert_instance_of Collection, LivePlayByPlay.find(game: "0022400001")
    end

    def test_find_parses_basic_timing_attributes
      stub_live_pbp_request

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_equal "0022400001", action.game_id
      assert_equal 1, action.action_number
      assert_equal "PT12M00.00S", action.clock
      assert_equal "2024-10-22T23:30:00Z", action.time_actual
    end

    def test_find_parses_period_attributes
      stub_live_pbp_request

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_equal 1, action.period
      assert_equal "REGULAR", action.period_type
    end

    def test_find_parses_action_type_attributes
      stub_live_pbp_request

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_equal "jumpball", action.action_type
      assert_equal "starting", action.sub_type
      assert_equal ["starting"], action.qualifiers
      assert_equal "Jump Ball", action.description
    end

    def test_find_parses_score_attributes
      stub_live_pbp_request

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_equal "0", action.score_home
      assert_equal "0", action.score_away
    end

    def test_find_parses_player_and_team_attributes
      stub_live_pbp_request

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_equal 201_939, action.player_id
      assert_equal "Stephen Curry", action.player_name
      assert_equal "S. Curry", action.player_name_i
      assert_equal 1_610_612_744, action.team_id
      assert_equal "GSW", action.team_tricode
    end

    def test_find_parses_shot_attributes
      stub_live_pbp_request

      actions = LivePlayByPlay.find(game: "0022400001")
      shot = actions.find { |a| a.action_type.eql?("3pt") }

      assert_in_delta 23.5, shot.x_legacy
      assert_in_delta 12.0, shot.y_legacy
      assert_in_delta 26.0, shot.shot_distance
      assert_equal 1, shot.is_field_goal
      assert_equal "Made", shot.shot_result
    end

    def test_find_parses_points_total
      stub_live_pbp_request

      actions = LivePlayByPlay.find(game: "0022400001")
      shot = actions.find { |a| a.action_type.eql?("3pt") }

      assert_equal 3, shot.points_total
    end

    def test_find_accepts_game_object
      stub_request(:get, /playbyplay_0022400001.json/).to_return(body: live_pbp_response.to_json)

      game = Game.new(id: "0022400001")
      LivePlayByPlay.find(game: game)

      assert_requested :get, /playbyplay_0022400001.json/
    end

    private

    def stub_live_pbp_request
      stub_request(:get, %r{playbyplay/playbyplay_0022400001.json})
        .to_return(body: live_pbp_response.to_json)
    end

    def live_pbp_response
      {game: {actions: [jumpball_action, three_point_action]}}
    end

    def jumpball_action
      {
        actionNumber: 1, clock: "PT12M00.00S", timeActual: "2024-10-22T23:30:00Z",
        period: 1, periodType: "REGULAR", actionType: "jumpball", subType: "starting",
        qualifiers: ["starting"], description: "Jump Ball", personId: 201_939,
        playerName: "Stephen Curry", playerNameI: "S. Curry",
        teamId: 1_610_612_744, teamTricode: "GSW", scoreHome: "0", scoreAway: "0"
      }
    end

    def three_point_action
      {
        actionNumber: 2, clock: "PT11M45.00S", timeActual: "2024-10-22T23:30:15Z",
        period: 1, periodType: "REGULAR", actionType: "3pt", subType: "jumpshot",
        qualifiers: [], description: "Curry 26' 3PT", personId: 201_939,
        playerName: "Stephen Curry", playerNameI: "S. Curry",
        teamId: 1_610_612_744, teamTricode: "GSW", scoreHome: "3", scoreAway: "0",
        pointsTotal: 3, xLegacy: 23.5, yLegacy: 12.0, shotDistance: 26.0,
        isFieldGoal: 1, shotResult: "Made"
      }
    end
  end
end
