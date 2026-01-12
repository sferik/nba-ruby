require_relative "cume_stats_team_populates_helper"

module NBA
  class CumeStatsTeamPopulatesPlayerAvgTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_avg_minutes
      assert_in_delta(35.0, find_result[:game_by_game].first.avg_minutes)
    end

    def test_populates_fgm_pg
      assert_in_delta(10.0, find_result[:game_by_game].first.fgm_pg)
    end

    def test_populates_fga_pg
      assert_in_delta(20.0, find_result[:game_by_game].first.fga_pg)
    end

    def test_populates_fg3m_pg
      assert_in_delta(4.0, find_result[:game_by_game].first.fg3m_pg)
    end

    def test_populates_fg3a_pg
      assert_in_delta(10.0, find_result[:game_by_game].first.fg3a_pg)
    end

    def test_populates_ftm_pg
      assert_in_delta(8.0, find_result[:game_by_game].first.ftm_pg)
    end

    def test_populates_fta_pg
      assert_in_delta(9.0, find_result[:game_by_game].first.fta_pg)
    end

    def test_populates_oreb_pg
      assert_in_delta(1.0, find_result[:game_by_game].first.oreb_pg)
    end

    def test_populates_dreb_pg
      assert_in_delta(5.0, find_result[:game_by_game].first.dreb_pg)
    end

    def test_populates_reb_pg
      assert_in_delta(6.0, find_result[:game_by_game].first.reb_pg)
    end

    def test_populates_ast_pg
      assert_in_delta(7.0, find_result[:game_by_game].first.ast_pg)
    end

    def test_populates_pf_pg
      assert_in_delta(2.0, find_result[:game_by_game].first.pf_pg)
    end

    def test_populates_stl_pg
      assert_in_delta(1.5, find_result[:game_by_game].first.stl_pg)
    end

    def test_populates_tov_pg
      assert_in_delta(2.5, find_result[:game_by_game].first.tov_pg)
    end

    def test_populates_blk_pg
      assert_in_delta(0.5, find_result[:game_by_game].first.blk_pg)
    end

    def test_populates_pts_pg
      assert_in_delta(28.0, find_result[:game_by_game].first.pts_pg)
    end
  end
end
