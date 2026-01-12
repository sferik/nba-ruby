require_relative "../cume_stats_player/cume_stats_player_missing_keys_helper"

module NBA
  class CumeStatsPlayerGameMissingKeysBasicTest < Minitest::Test
    include CumeStatsPlayerMissingKeysHelper

    cover CumeStatsPlayer

    def test_handles_missing_game_id_key
      stub_with_game_headers_except("GAME_ID")

      assert_nil find_result[:game_by_game].first.game_id
    end

    def test_handles_missing_matchup_key
      stub_with_game_headers_except("MATCHUP")

      assert_nil find_result[:game_by_game].first.matchup
    end

    def test_handles_missing_game_date_key
      stub_with_game_headers_except("GAME_DATE")

      assert_nil find_result[:game_by_game].first.game_date
    end

    def test_handles_missing_vs_team_id_key
      stub_with_game_headers_except("VS_TEAM_ID")

      assert_nil find_result[:game_by_game].first.vs_team_id
    end

    def test_handles_missing_vs_team_city_key
      stub_with_game_headers_except("VS_TEAM_CITY")

      assert_nil find_result[:game_by_game].first.vs_team_city
    end

    def test_handles_missing_vs_team_name_key
      stub_with_game_headers_except("VS_TEAM_NAME")

      assert_nil find_result[:game_by_game].first.vs_team_name
    end

    def test_handles_missing_min_key
      stub_with_game_headers_except("MIN")

      assert_nil find_result[:game_by_game].first.min
    end

    def test_handles_missing_sec_key
      stub_with_game_headers_except("SEC")

      assert_nil find_result[:game_by_game].first.sec
    end
  end
end
