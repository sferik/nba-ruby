require_relative "../cume_stats_player/cume_stats_player_missing_keys_helper"

module NBA
  class CumeStatsPlayerTotalMissingKeysBasicTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_player_id_key
      stub_with_total_headers_except("PLAYER_ID")

      assert_nil find_result[:total].player_id
    end

    def test_handles_missing_player_name_key
      stub_with_total_headers_except("PLAYER_NAME")

      assert_nil find_result[:total].player_name
    end

    def test_handles_missing_jersey_num_key
      stub_with_total_headers_except("JERSEY_NUM")

      assert_nil find_result[:total].jersey_num
    end

    def test_handles_missing_season_key
      stub_with_total_headers_except("SEASON")

      assert_nil find_result[:total].season
    end

    def test_handles_missing_gp_key
      stub_with_total_headers_except("GP")

      assert_nil find_result[:total].gp
    end

    def test_handles_missing_gs_key
      stub_with_total_headers_except("GS")

      assert_nil find_result[:total].gs
    end

    def test_handles_missing_actual_minutes_key
      stub_with_total_headers_except("ACTUAL_MINUTES")

      assert_nil find_result[:total].actual_minutes
    end

    def test_handles_missing_actual_seconds_key
      stub_with_total_headers_except("ACTUAL_SECONDS")

      assert_nil find_result[:total].actual_seconds
    end
  end
end
