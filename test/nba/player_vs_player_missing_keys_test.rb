require_relative "../test_helper"

module NBA
  class PlayerVsPlayerMissingKeysTest < Minitest::Test
    cover PlayerVsPlayer

    def test_handles_missing_player_id_key
      assert_nil build_stat_without("PLAYER_ID").player_id
    end

    def test_handles_missing_vs_player_id_key
      assert_nil build_stat_without("VS_PLAYER_ID").vs_player_id
    end

    def test_handles_missing_court_status_key
      assert_nil build_stat_without("COURT_STATUS").court_status
    end

    def test_handles_missing_gp_key
      assert_nil build_stat_without("GP").gp
    end

    def test_handles_missing_min_key
      assert_nil build_stat_without("MIN").min
    end

    def test_handles_missing_pts_key
      assert_nil build_stat_without("PTS").pts
    end

    def test_handles_missing_reb_key
      assert_nil build_stat_without("REB").reb
    end

    def test_handles_missing_ast_key
      assert_nil build_stat_without("AST").ast
    end

    def test_handles_missing_stl_key
      assert_nil build_stat_without("STL").stl
    end

    def test_handles_missing_blk_key
      assert_nil build_stat_without("BLK").blk
    end

    def test_handles_missing_tov_key
      assert_nil build_stat_without("TOV").tov
    end

    def test_handles_missing_fg_pct_key
      assert_nil build_stat_without("FG_PCT").fg_pct
    end

    def test_handles_missing_plus_minus_key
      assert_nil build_stat_without("PLUS_MINUS").plus_minus
    end

    private

    def build_stat_without(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      row = all_values.first(headers.size)
      stub_request(:get, /playervsplayer.*PlayerID=201939/)
        .to_return(body: {resultSets: [{name: "Overall", headers: headers, rowSet: [row]}]}.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: 201_566).first
    end

    def all_headers
      %w[PLAYER_ID VS_PLAYER_ID COURT_STATUS GP MIN PTS REB AST STL BLK TOV FG_PCT PLUS_MINUS]
    end

    def all_values
      [201_939, 201_566, "Overall", 24, 32.5, 26.4, 5.7, 6.1, 1.2, 0.3, 3.1, 0.467, 8.5]
    end
  end
end
