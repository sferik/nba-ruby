require_relative "../test_helper"

module NBA
  class PlayerDashPtShotDefendMissingKeysTest < Minitest::Test
    cover PlayerDashPtShotDefend

    def test_handles_missing_close_def_person_id_key
      assert_nil build_stat_without("CLOSE_DEF_PERSON_ID").close_def_person_id
    end

    def test_handles_missing_gp_key
      assert_nil build_stat_without("GP").gp
    end

    def test_handles_missing_g_key
      assert_nil build_stat_without("G").g
    end

    def test_handles_missing_defense_category_key
      assert_nil build_stat_without("DEFENSE_CATEGORY").defense_category
    end

    def test_handles_missing_freq_key
      assert_nil build_stat_without("FREQ").freq
    end

    def test_handles_missing_d_fgm_key
      assert_nil build_stat_without("D_FGM").d_fgm
    end

    def test_handles_missing_d_fga_key
      assert_nil build_stat_without("D_FGA").d_fga
    end

    def test_handles_missing_d_fg_pct_key
      assert_nil build_stat_without("D_FG_PCT").d_fg_pct
    end

    def test_handles_missing_normal_fg_pct_key
      assert_nil build_stat_without("NORMAL_FG_PCT").normal_fg_pct
    end

    def test_handles_missing_pct_plusminus_key
      assert_nil build_stat_without("PCT_PLUSMINUS").pct_plusminus
    end

    private

    def build_stat_without(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      row = all_values.first(headers.size)
      stub_request(:get, /playerdashptshotdefend.*PlayerID=201939/)
        .to_return(body: {resultSets: [{name: "DefendingShots", headers: headers, rowSet: [row]}]}.to_json)
      PlayerDashPtShotDefend.find(player: 201_939).first
    end

    def all_headers
      %w[CLOSE_DEF_PERSON_ID GP G DEFENSE_CATEGORY FREQ D_FGM D_FGA D_FG_PCT NORMAL_FG_PCT PCT_PLUSMINUS]
    end

    def all_values
      [201_939, 74, 74, "Overall", 0.15, 3.5, 8.2, 0.427, 0.485, -5.8]
    end
  end
end
