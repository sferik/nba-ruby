require_relative "../test_helper"

module NBA
  class LivePlayByPlayScoreAndShotFieldsTest < Minitest::Test
    cover LivePlayByPlay

    def test_handles_missing_score_home
      stub_live_pbp_request_without("scoreHome")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.score_home
    end

    def test_handles_missing_score_away
      stub_live_pbp_request_without("scoreAway")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.score_away
    end

    def test_handles_missing_points_total
      stub_live_pbp_request_without("pointsTotal")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.points_total
    end

    def test_handles_missing_x_legacy
      stub_live_pbp_request_without("xLegacy")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.x_legacy
    end

    def test_handles_missing_y_legacy
      stub_live_pbp_request_without("yLegacy")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.y_legacy
    end

    def test_handles_missing_shot_distance
      stub_live_pbp_request_without("shotDistance")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.shot_distance
    end

    def test_handles_missing_is_field_goal
      stub_live_pbp_request_without("isFieldGoal")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.is_field_goal
    end

    def test_handles_missing_shot_result
      stub_live_pbp_request_without("shotResult")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.shot_result
    end

    private

    def stub_live_pbp_request_without(key)
      action = base_action.reject { |k, _| k.to_s.eql?(key.to_s) }
      response = {game: {actions: [action]}}
      stub_request(:get, %r{playbyplay/playbyplay_0022400001.json})
        .to_return(body: response.to_json)
    end

    def base_action
      {
        actionNumber: 1, clock: "PT12M00.00S", timeActual: "2024-10-22T23:30:00Z",
        period: 1, periodType: "REGULAR", actionType: "jumpball", subType: "starting",
        qualifiers: ["starting"], description: "Jump Ball", personId: 201_939,
        playerName: "Stephen Curry", playerNameI: "S. Curry",
        teamId: 1_610_612_744, teamTricode: "GSW", scoreHome: "0", scoreAway: "0",
        pointsTotal: 0, xLegacy: 0.0, yLegacy: 0.0, shotDistance: 0.0,
        isFieldGoal: 0, shotResult: "Missed"
      }
    end
  end
end
