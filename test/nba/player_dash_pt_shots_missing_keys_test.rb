require_relative "../test_helper"

module NBA
  class PlayerDashPtShotsMissingKeysTest < Minitest::Test
    cover PlayerDashPtShots

    def test_handles_missing_player_id_key
      assert_nil build_stat_without("PLAYER_ID").player_id
    end

    def test_handles_missing_player_name_last_first_key
      assert_nil build_stat_without("PLAYER_NAME_LAST_FIRST").player_name_last_first
    end

    def test_handles_missing_sort_order_key
      assert_nil build_stat_without("SORT_ORDER").sort_order
    end

    def test_handles_missing_gp_key
      assert_nil build_stat_without("GP").gp
    end

    def test_handles_missing_g_key
      assert_nil build_stat_without("G").g
    end

    def test_handles_missing_shot_type_key
      assert_nil build_stat_without("SHOT_TYPE").shot_type
    end

    def test_handles_missing_fga_frequency_key
      assert_nil build_stat_without("FGA_FREQUENCY").fga_frequency
    end

    def test_handles_missing_fgm_key
      assert_nil build_stat_without("FGM").fgm
    end

    def test_handles_missing_fga_key
      assert_nil build_stat_without("FGA").fga
    end

    def test_handles_missing_fg_pct_key
      assert_nil build_stat_without("FG_PCT").fg_pct
    end

    def test_handles_missing_efg_pct_key
      assert_nil build_stat_without("EFG_PCT").efg_pct
    end

    def test_handles_missing_fg2a_frequency_key
      assert_nil build_stat_without("FG2A_FREQUENCY").fg2a_frequency
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

    def test_handles_missing_fg3a_frequency_key
      assert_nil build_stat_without("FG3A_FREQUENCY").fg3a_frequency
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
      stub_request(:get, /playerdashptshots.*PlayerID=201939/)
        .to_return(body: {resultSets: [{name: "Overall", headers: headers, rowSet: [row]}]}.to_json)
      PlayerDashPtShots.overall(player: 201_939).first
    end

    def all_headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER GP G SHOT_TYPE FGA_FREQUENCY FGM FGA FG_PCT
        EFG_PCT FG2A_FREQUENCY FG2M FG2A FG2_PCT FG3A_FREQUENCY FG3M FG3A FG3_PCT]
    end

    def all_values
      [201_939, "Curry, Stephen", 1, 74, 74, "Overall", 1.0, 8.5, 18.2, 0.467, 0.563, 0.45, 4.2,
        8.1, 0.519, 0.55, 4.3, 10.1, 0.426]
    end
  end
end
