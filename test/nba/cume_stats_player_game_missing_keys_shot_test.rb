require_relative "cume_stats_player_missing_keys_helper"

module NBA
  class CumeStatsPlayerGameMissingKeysShotTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_fgm_key
      stub_with_game_headers_except("FGM")

      assert_nil find_result[:game_by_game].first.fgm
    end

    def test_handles_missing_fga_key
      stub_with_game_headers_except("FGA")

      assert_nil find_result[:game_by_game].first.fga
    end

    def test_handles_missing_fg_pct_key
      stub_with_game_headers_except("FG_PCT")

      assert_nil find_result[:game_by_game].first.fg_pct
    end

    def test_handles_missing_fg3m_key
      stub_with_game_headers_except("FG3M")

      assert_nil find_result[:game_by_game].first.fg3m
    end

    def test_handles_missing_fg3a_key
      stub_with_game_headers_except("FG3A")

      assert_nil find_result[:game_by_game].first.fg3a
    end

    def test_handles_missing_fg3_pct_key
      stub_with_game_headers_except("FG3_PCT")

      assert_nil find_result[:game_by_game].first.fg3_pct
    end

    def test_handles_missing_ftm_key
      stub_with_game_headers_except("FTM")

      assert_nil find_result[:game_by_game].first.ftm
    end

    def test_handles_missing_fta_key
      stub_with_game_headers_except("FTA")

      assert_nil find_result[:game_by_game].first.fta
    end

    def test_handles_missing_ft_pct_key
      stub_with_game_headers_except("FT_PCT")

      assert_nil find_result[:game_by_game].first.ft_pct
    end
  end
end
