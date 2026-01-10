require_relative "cume_stats_team_missing_keys_player_helper"

module NBA
  class CumeStatsTeamMissingKeysPlayerTest < Minitest::Test
    include CumeStatsTeamMissingKeysPlayerHelper

    cover CumeStatsTeam

    def test_handles_missing_person_id_key
      stub_missing_key("PERSON_ID")

      assert_nil find_result[:game_by_game].first.person_id
    end

    def test_handles_missing_player_name_key
      stub_missing_key("PLAYER_NAME")

      assert_nil find_result[:game_by_game].first.player_name
    end

    def test_handles_missing_jersey_num_key
      stub_missing_key("JERSEY_NUM")

      assert_nil find_result[:game_by_game].first.jersey_num
    end

    def test_handles_missing_gp_key
      stub_missing_key("GP")

      assert_nil find_result[:game_by_game].first.gp
    end

    def test_handles_missing_fgm_key
      stub_missing_key("FGM")

      assert_nil find_result[:game_by_game].first.fgm
    end

    def test_handles_missing_pts_key
      stub_missing_key("PTS")

      assert_nil find_result[:game_by_game].first.pts
    end

    def test_handles_missing_avg_minutes_key
      stub_missing_key("AVG_MINUTES")

      assert_nil find_result[:game_by_game].first.avg_minutes
    end

    def test_handles_missing_pts_per_min_key
      stub_missing_key("PTS_PER_MIN")

      assert_nil find_result[:game_by_game].first.pts_per_min
    end

    private

    def stub_missing_key(key)
      headers = all_headers.reject { |h| h.eql?(key) }
      row = build_row_without(key)
      response = build_response(headers, row)
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end
  end
end
