require_relative "../../test_helper"

module NBA
  class PlayerDashPtPassMissingShootingKeysTest < Minitest::Test
    cover PlayerDashPtPass

    def test_handles_missing_fgm_key
      assert_nil build_stat_without("FGM").fgm
    end

    def test_handles_missing_fga_key
      assert_nil build_stat_without("FGA").fga
    end

    def test_handles_missing_fg_pct_key
      assert_nil build_stat_without("FG_PCT").fg_pct
    end

    def test_handles_missing_fg2m_key
      assert_nil build_stat_without("FG2M").fg2m
    end

    def test_handles_missing_fg2a_key
      assert_nil build_stat_without("FG2A").fg2a
    end

    def test_handles_missing_fg2_pct_key
      assert_nil build_stat_without("FG2_PCT").fg2_pct
    end

    def test_handles_missing_fg3m_key
      assert_nil build_stat_without("FG3M").fg3m
    end

    def test_handles_missing_fg3a_key
      assert_nil build_stat_without("FG3A").fg3a
    end

    def test_handles_missing_fg3_pct_key
      assert_nil build_stat_without("FG3_PCT").fg3_pct
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
