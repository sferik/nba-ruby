require_relative "../../test_helper"

module NBA
  class PlayerDashPtPassPassesReceivedValuesTest < Minitest::Test
    cover PlayerDashPtPass

    def test_passes_received_identity_values
      stat = passes_received_stat

      assert_equal 201_939, stat.player_id
      assert_equal "Curry, Stephen", stat.player_name_last_first
      assert_equal 1_610_612_744, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal 203_110, stat.pass_teammate_player_id
    end

    def test_passes_received_pass_values
      stat = passes_received_stat

      assert_equal "Draymond Green", stat.pass_to
      assert_equal 74, stat.gp
      assert_equal 74, stat.g
      assert_equal "Received", stat.pass_type
      assert_in_delta 0.20, stat.frequency
    end

    def test_passes_received_pass_assist_values
      stat = passes_received_stat

      assert_in_delta 3.8, stat.pass
      assert_in_delta 1.5, stat.ast
    end

    def test_passes_received_fg_values
      stat = passes_received_stat

      assert_in_delta 2.8, stat.fgm
      assert_in_delta 5.5, stat.fga
      assert_in_delta 0.509, stat.fg_pct
    end

    def test_passes_received_fg2_values
      stat = passes_received_stat

      assert_in_delta 1.2, stat.fg2m
      assert_in_delta 2.5, stat.fg2a
      assert_in_delta 0.480, stat.fg2_pct
    end

    def test_passes_received_fg3_values
      stat = passes_received_stat

      assert_in_delta 1.6, stat.fg3m
      assert_in_delta 3.0, stat.fg3a
      assert_in_delta 0.533, stat.fg3_pct
    end

    private

    def passes_received_stat
      stub_request(:get, /playerdashptpass/).to_return(body: passes_received_response.to_json)
      PlayerDashPtPass.passes_received(player: 201_939).first
    end

    def passes_received_response
      {resultSets: [{name: "PassesReceived", headers: headers,
                     rowSet: [[201_939, "Curry, Stephen", 1_610_612_744, "GSW", 203_110, "Draymond Green",
                       74, 74, "Received", 0.20, 3.8, 1.5, 2.8, 5.5, 0.509, 1.2, 2.5, 0.480, 1.6, 3.0, 0.533]]}]}
    end

    def headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST TEAM_ID TEAM_ABBREVIATION PASS_TEAMMATE_PLAYER_ID
        PASS_TO GP G PASS_TYPE FREQUENCY PASS AST FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end
  end
end
