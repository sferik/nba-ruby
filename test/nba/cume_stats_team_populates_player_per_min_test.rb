require_relative "cume_stats_team_populates_helper"

module NBA
  class CumeStatsTeamPopulatesPlayerPerMinTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_fgm_per_min
      assert_in_delta(0.286, find_result[:game_by_game].first.fgm_per_min)
    end

    def test_populates_fga_per_min
      assert_in_delta(0.571, find_result[:game_by_game].first.fga_per_min)
    end

    def test_populates_fg3m_per_min
      assert_in_delta(0.114, find_result[:game_by_game].first.fg3m_per_min)
    end

    def test_populates_fg3a_per_min
      assert_in_delta(0.286, find_result[:game_by_game].first.fg3a_per_min)
    end

    def test_populates_ftm_per_min
      assert_in_delta(0.229, find_result[:game_by_game].first.ftm_per_min)
    end

    def test_populates_fta_per_min
      assert_in_delta(0.257, find_result[:game_by_game].first.fta_per_min)
    end

    def test_populates_oreb_per_min
      assert_in_delta(0.029, find_result[:game_by_game].first.oreb_per_min)
    end

    def test_populates_dreb_per_min
      assert_in_delta(0.143, find_result[:game_by_game].first.dreb_per_min)
    end

    def test_populates_reb_per_min
      assert_in_delta(0.171, find_result[:game_by_game].first.reb_per_min)
    end

    def test_populates_ast_per_min
      assert_in_delta(0.200, find_result[:game_by_game].first.ast_per_min)
    end

    def test_populates_pf_per_min
      assert_in_delta(0.057, find_result[:game_by_game].first.pf_per_min)
    end

    def test_populates_stl_per_min
      assert_in_delta(0.043, find_result[:game_by_game].first.stl_per_min)
    end

    def test_populates_tov_per_min
      assert_in_delta(0.071, find_result[:game_by_game].first.tov_per_min)
    end

    def test_populates_blk_per_min
      assert_in_delta(0.014, find_result[:game_by_game].first.blk_per_min)
    end

    def test_populates_pts_per_min
      assert_in_delta(0.800, find_result[:game_by_game].first.pts_per_min)
    end
  end
end
