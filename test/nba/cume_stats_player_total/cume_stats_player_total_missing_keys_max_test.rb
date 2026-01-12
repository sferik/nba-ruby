require_relative "../cume_stats_player/cume_stats_player_missing_keys_helper"

module NBA
  class CumeStatsPlayerTotalMissingKeysMaxTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_max_min_key
      stub_with_total_headers_except("MAX_MIN")

      assert_nil find_result[:total].max_min
    end

    def test_handles_missing_max_fgm_key
      stub_with_total_headers_except("MAX_FGM")

      assert_nil find_result[:total].max_fgm
    end

    def test_handles_missing_max_fga_key
      stub_with_total_headers_except("MAX_FGA")

      assert_nil find_result[:total].max_fga
    end

    def test_handles_missing_max_fg3m_key
      stub_with_total_headers_except("MAX_FG3M")

      assert_nil find_result[:total].max_fg3m
    end

    def test_handles_missing_max_fg3a_key
      stub_with_total_headers_except("MAX_FG3A")

      assert_nil find_result[:total].max_fg3a
    end

    def test_handles_missing_max_ftm_key
      stub_with_total_headers_except("MAX_FTM")

      assert_nil find_result[:total].max_ftm
    end

    def test_handles_missing_max_fta_key
      stub_with_total_headers_except("MAX_FTA")

      assert_nil find_result[:total].max_fta
    end

    def test_handles_missing_max_oreb_key
      stub_with_total_headers_except("MAX_OREB")

      assert_nil find_result[:total].max_oreb
    end

    def test_handles_missing_max_dreb_key
      stub_with_total_headers_except("MAX_DREB")

      assert_nil find_result[:total].max_dreb
    end

    def test_handles_missing_max_reb_key
      stub_with_total_headers_except("MAX_REB")

      assert_nil find_result[:total].max_reb
    end

    def test_handles_missing_max_ast_key
      stub_with_total_headers_except("MAX_AST")

      assert_nil find_result[:total].max_ast
    end

    def test_handles_missing_max_pf_key
      stub_with_total_headers_except("MAX_PF")

      assert_nil find_result[:total].max_pf
    end

    def test_handles_missing_max_stl_key
      stub_with_total_headers_except("MAX_STL")

      assert_nil find_result[:total].max_stl
    end

    def test_handles_missing_max_tov_key
      stub_with_total_headers_except("MAX_TOV")

      assert_nil find_result[:total].max_tov
    end

    def test_handles_missing_max_blk_key
      stub_with_total_headers_except("MAX_BLK")

      assert_nil find_result[:total].max_blk
    end

    def test_handles_missing_max_pts_key
      stub_with_total_headers_except("MAX_PTS")

      assert_nil find_result[:total].max_pts
    end
  end
end
