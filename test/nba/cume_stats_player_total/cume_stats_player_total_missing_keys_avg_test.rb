require_relative "../cume_stats_player/cume_stats_player_missing_keys_helper"

module NBA
  class CumeStatsPlayerTotalMissingKeysAvgTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_avg_min_key
      stub_with_total_headers_except("AVG_MIN")

      assert_nil find_result[:total].avg_min
    end

    def test_handles_missing_avg_sec_key
      stub_with_total_headers_except("AVG_SEC")

      assert_nil find_result[:total].avg_sec
    end

    def test_handles_missing_avg_fgm_key
      stub_with_total_headers_except("AVG_FGM")

      assert_nil find_result[:total].avg_fgm
    end

    def test_handles_missing_avg_fga_key
      stub_with_total_headers_except("AVG_FGA")

      assert_nil find_result[:total].avg_fga
    end

    def test_handles_missing_avg_fg3m_key
      stub_with_total_headers_except("AVG_FG3M")

      assert_nil find_result[:total].avg_fg3m
    end

    def test_handles_missing_avg_fg3a_key
      stub_with_total_headers_except("AVG_FG3A")

      assert_nil find_result[:total].avg_fg3a
    end

    def test_handles_missing_avg_ftm_key
      stub_with_total_headers_except("AVG_FTM")

      assert_nil find_result[:total].avg_ftm
    end

    def test_handles_missing_avg_fta_key
      stub_with_total_headers_except("AVG_FTA")

      assert_nil find_result[:total].avg_fta
    end

    def test_handles_missing_avg_oreb_key
      stub_with_total_headers_except("AVG_OREB")

      assert_nil find_result[:total].avg_oreb
    end

    def test_handles_missing_avg_dreb_key
      stub_with_total_headers_except("AVG_DREB")

      assert_nil find_result[:total].avg_dreb
    end

    def test_handles_missing_avg_tot_reb_key
      stub_with_total_headers_except("AVG_TOT_REB")

      assert_nil find_result[:total].avg_tot_reb
    end

    def test_handles_missing_avg_ast_key
      stub_with_total_headers_except("AVG_AST")

      assert_nil find_result[:total].avg_ast
    end

    def test_handles_missing_avg_pf_key
      stub_with_total_headers_except("AVG_PF")

      assert_nil find_result[:total].avg_pf
    end

    def test_handles_missing_avg_stl_key
      stub_with_total_headers_except("AVG_STL")

      assert_nil find_result[:total].avg_stl
    end

    def test_handles_missing_avg_tov_key
      stub_with_total_headers_except("AVG_TOV")

      assert_nil find_result[:total].avg_tov
    end

    def test_handles_missing_avg_blk_key
      stub_with_total_headers_except("AVG_BLK")

      assert_nil find_result[:total].avg_blk
    end

    def test_handles_missing_avg_pts_key
      stub_with_total_headers_except("AVG_PTS")

      assert_nil find_result[:total].avg_pts
    end
  end
end
