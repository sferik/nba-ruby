require_relative "../../test_helper"

module NBA
  class PlayerDashPtPassMissingIdentityKeysTest < Minitest::Test
    cover PlayerDashPtPass

    def test_handles_missing_player_id_key
      assert_nil build_stat_without("PLAYER_ID").player_id
    end

    def test_handles_missing_player_name_last_first_key
      assert_nil build_stat_without("PLAYER_NAME_LAST_FIRST").player_name_last_first
    end

    def test_handles_missing_team_id_key
      assert_nil build_stat_without("TEAM_ID").team_id
    end

    def test_handles_missing_team_abbreviation_key
      assert_nil build_stat_without("TEAM_ABBREVIATION").team_abbreviation
    end

    def test_handles_missing_pass_teammate_player_id_key
      assert_nil build_stat_without("PASS_TEAMMATE_PLAYER_ID").pass_teammate_player_id
    end

    def test_handles_missing_pass_to_key
      assert_nil build_stat_without("PASS_TO").pass_to
    end

    def test_handles_missing_gp_key
      assert_nil build_stat_without("GP").gp
    end

    def test_handles_missing_g_key
      assert_nil build_stat_without("G").g
    end

    def test_handles_missing_pass_type_key
      assert_nil build_stat_without("PASS_TYPE").pass_type
    end

    def test_handles_missing_frequency_key
      assert_nil build_stat_without("FREQUENCY").frequency
    end

    def test_handles_missing_pass_key
      assert_nil build_stat_without("PASS").pass
    end

    def test_handles_missing_ast_key
      assert_nil build_stat_without("AST").ast
    end

    private

    def build_stat_without(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      row = all_values.first(headers.size)
      stub_request(:get, /playerdashptpass.*PlayerID=201939/)
        .to_return(body: {resultSets: [{name: "PassesMade", headers: headers, rowSet: [row]}]}.to_json)
      PlayerDashPtPass.passes_made(player: 201_939).first
    end

    def all_headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST TEAM_ID TEAM_ABBREVIATION PASS_TEAMMATE_PLAYER_ID
        PASS_TO GP G PASS_TYPE FREQUENCY PASS AST FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def all_values
      [201_939, "Curry, Stephen", 1_610_612_744, "GSW", 202_691, "Klay Thompson", 74, 74, "Made",
        0.25, 5.2, 2.1, 3.5, 7.2, 0.486, 1.5, 3.0, 0.500, 2.0, 4.2, 0.476]
    end
  end
end
