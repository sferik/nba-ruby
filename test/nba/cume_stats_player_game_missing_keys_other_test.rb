require_relative "cume_stats_player_missing_keys_helper"

module NBA
  class CumeStatsPlayerGameMissingKeysOtherTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_oreb_key
      stub_with_game_headers_except("OREB")

      assert_nil find_result[:game_by_game].first.oreb
    end

    def test_handles_missing_dreb_key
      stub_with_game_headers_except("DREB")

      assert_nil find_result[:game_by_game].first.dreb
    end

    def test_handles_missing_reb_key
      stub_with_game_headers_except("REB")

      assert_nil find_result[:game_by_game].first.reb
    end

    def test_handles_missing_ast_key
      stub_with_game_headers_except("AST")

      assert_nil find_result[:game_by_game].first.ast
    end

    def test_handles_missing_pf_key
      stub_with_game_headers_except("PF")

      assert_nil find_result[:game_by_game].first.pf
    end

    def test_handles_missing_stl_key
      stub_with_game_headers_except("STL")

      assert_nil find_result[:game_by_game].first.stl
    end

    def test_handles_missing_tov_key
      stub_with_game_headers_except("TOV")

      assert_nil find_result[:game_by_game].first.tov
    end

    def test_handles_missing_blk_key
      stub_with_game_headers_except("BLK")

      assert_nil find_result[:game_by_game].first.blk
    end

    def test_handles_missing_pts_key
      stub_with_game_headers_except("PTS")

      assert_nil find_result[:game_by_game].first.pts
    end
  end
end
