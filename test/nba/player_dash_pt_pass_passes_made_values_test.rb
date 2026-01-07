require_relative "../test_helper"

module NBA
  class PlayerDashPtPassPassesMadeValuesTest < Minitest::Test
    cover PlayerDashPtPass

    def test_passes_made_identity_values
      stat = passes_made_stat

      assert_equal 201_939, stat.player_id
      assert_equal "Curry, Stephen", stat.player_name_last_first
      assert_equal 1_610_612_744, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal 202_691, stat.pass_teammate_player_id
    end

    def test_passes_made_pass_values
      stat = passes_made_stat

      assert_equal "Klay Thompson", stat.pass_to
      assert_equal 74, stat.gp
      assert_equal 74, stat.g
      assert_equal "Made", stat.pass_type
      assert_in_delta 0.25, stat.frequency
    end

    def test_passes_made_pass_assist_values
      stat = passes_made_stat

      assert_in_delta 5.2, stat.pass
      assert_in_delta 2.1, stat.ast
    end

    def test_passes_made_fg_values
      stat = passes_made_stat

      assert_in_delta 3.5, stat.fgm
      assert_in_delta 7.2, stat.fga
      assert_in_delta 0.486, stat.fg_pct
    end

    def test_passes_made_fg2_values
      stat = passes_made_stat

      assert_in_delta 1.5, stat.fg2m
      assert_in_delta 3.0, stat.fg2a
      assert_in_delta 0.500, stat.fg2_pct
    end

    def test_passes_made_fg3_values
      stat = passes_made_stat

      assert_in_delta 2.0, stat.fg3m
      assert_in_delta 4.2, stat.fg3a
      assert_in_delta 0.476, stat.fg3_pct
    end

    private

    def passes_made_stat
      stub_request(:get, /playerdashptpass/).to_return(body: passes_made_response.to_json)
      PlayerDashPtPass.passes_made(player: 201_939).first
    end

    def passes_made_response
      {resultSets: [{name: "PassesMade", headers: headers,
                     rowSet: [[201_939, "Curry, Stephen", 1_610_612_744, "GSW", 202_691, "Klay Thompson",
                       74, 74, "Made", 0.25, 5.2, 2.1, 3.5, 7.2, 0.486, 1.5, 3.0, 0.500, 2.0, 4.2, 0.476]]}]}
    end

    def headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST TEAM_ID TEAM_ABBREVIATION PASS_TEAMMATE_PLAYER_ID
        PASS_TO GP G PASS_TYPE FREQUENCY PASS AST FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end
  end
end
