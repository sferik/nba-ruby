require_relative "../../test_helper"

module NBA
  class LivePlayByPlayActionFieldsTest < Minitest::Test
    cover LivePlayByPlay

    def test_handles_missing_action_number
      stub_live_pbp_request_without("actionNumber")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.action_number
    end

    def test_handles_missing_clock
      stub_live_pbp_request_without("clock")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.clock
    end

    def test_handles_missing_time_actual
      stub_live_pbp_request_without("timeActual")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.time_actual
    end

    def test_handles_missing_period
      stub_live_pbp_request_without("period")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.period
    end

    def test_handles_missing_period_type
      stub_live_pbp_request_without("periodType")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.period_type
    end

    def test_handles_missing_action_type
      stub_live_pbp_request_without("actionType")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.action_type
    end

    def test_handles_missing_sub_type
      stub_live_pbp_request_without("subType")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.sub_type
    end

    def test_handles_missing_qualifiers
      stub_live_pbp_request_without("qualifiers")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.qualifiers
    end

    def test_handles_missing_description
      stub_live_pbp_request_without("description")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.description
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
