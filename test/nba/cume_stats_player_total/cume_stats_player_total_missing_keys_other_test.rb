require_relative "../cume_stats_player/cume_stats_player_missing_keys_helper"

module NBA
  class CumeStatsPlayerTotalMissingKeysOtherTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_oreb_key
      stub_with_total_headers_except("OREB")

      assert_nil find_result[:total].oreb
    end

    def test_handles_missing_dreb_key
      stub_with_total_headers_except("DREB")

      assert_nil find_result[:total].dreb
    end

    def test_handles_missing_tot_reb_key
      stub_with_total_headers_except("TOT_REB")

      assert_nil find_result[:total].tot_reb
    end

    def test_handles_missing_ast_key
      stub_with_total_headers_except("AST")

      assert_nil find_result[:total].ast
    end

    def test_handles_missing_pf_key
      stub_with_total_headers_except("PF")

      assert_nil find_result[:total].pf
    end

    def test_handles_missing_stl_key
      stub_with_total_headers_except("STL")

      assert_nil find_result[:total].stl
    end

    def test_handles_missing_tov_key
      stub_with_total_headers_except("TOV")

      assert_nil find_result[:total].tov
    end

    def test_handles_missing_blk_key
      stub_with_total_headers_except("BLK")

      assert_nil find_result[:total].blk
    end

    def test_handles_missing_pts_key
      stub_with_total_headers_except("PTS")

      assert_nil find_result[:total].pts
    end
  end
end
