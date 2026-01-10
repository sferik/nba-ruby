require_relative "cume_stats_team_populates_helper"

module NBA
  class CumeStatsTeamPopulatesPlayerOtherTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_oreb
      assert_equal 10, find_result[:game_by_game].first.oreb
    end

    def test_populates_dreb
      assert_equal 50, find_result[:game_by_game].first.dreb
    end

    def test_populates_tot_reb
      assert_equal 60, find_result[:game_by_game].first.tot_reb
    end

    def test_populates_ast
      assert_equal 70, find_result[:game_by_game].first.ast
    end

    def test_populates_pf
      assert_equal 20, find_result[:game_by_game].first.pf
    end

    def test_populates_stl
      assert_equal 15, find_result[:game_by_game].first.stl
    end

    def test_populates_tov
      assert_equal 25, find_result[:game_by_game].first.tov
    end

    def test_populates_blk
      assert_equal 5, find_result[:game_by_game].first.blk
    end

    def test_populates_pts
      assert_equal 280, find_result[:game_by_game].first.pts
    end
  end
end
