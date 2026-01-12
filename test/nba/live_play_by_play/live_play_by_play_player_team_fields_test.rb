require_relative "../../test_helper"

module NBA
  class LivePlayByPlayPlayerTeamFieldsTest < Minitest::Test
    cover LivePlayByPlay

    def test_handles_missing_person_id
      stub_live_pbp_request_without("personId")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.player_id
    end

    def test_handles_missing_player_name
      stub_live_pbp_request_without("playerName")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.player_name
    end

    def test_handles_missing_player_name_i
      stub_live_pbp_request_without("playerNameI")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.player_name_i
    end

    def test_handles_missing_team_id
      stub_live_pbp_request_without("teamId")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.team_id
    end

    def test_handles_missing_team_tricode
      stub_live_pbp_request_without("teamTricode")

      action = LivePlayByPlay.find(game: "0022400001").first

      assert_nil action.team_tricode
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
