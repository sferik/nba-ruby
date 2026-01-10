require_relative "cume_stats_team_missing_keys_total_helper"

module NBA
  class CumeStatsTeamMissingKeysTotalTest < Minitest::Test
    include CumeStatsTeamMissingKeysTotalHelper

    cover CumeStatsTeam

    def test_handles_missing_team_id_key
      stub_missing_key("TEAM_ID")

      assert_nil find_result[:total].team_id
    end

    def test_handles_missing_city_key
      stub_missing_key("CITY")

      assert_nil find_result[:total].city
    end

    def test_handles_missing_nickname_key
      stub_missing_key("NICKNAME")

      assert_nil find_result[:total].nickname
    end

    def test_handles_missing_w_key
      stub_missing_key("W")

      assert_nil find_result[:total].w
    end

    def test_handles_missing_fgm_key
      stub_missing_key("FGM")

      assert_nil find_result[:total].fgm
    end

    def test_handles_missing_pts_key
      stub_missing_key("PTS")

      assert_nil find_result[:total].pts
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
