require_relative "cume_stats_team_populates_helper"

module NBA
  class CumeStatsTeamPopulatesTotalOtherTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_oreb
      assert_equal 100, find_result[:total].oreb
    end

    def test_populates_dreb
      assert_equal 350, find_result[:total].dreb
    end

    def test_populates_tot_reb
      assert_equal 450, find_result[:total].tot_reb
    end

    def test_populates_ast
      assert_equal 250, find_result[:total].ast
    end

    def test_populates_pf
      assert_equal 180, find_result[:total].pf
    end

    def test_populates_stl
      assert_equal 80, find_result[:total].stl
    end

    def test_populates_tov
      assert_equal 120, find_result[:total].tov
    end

    def test_populates_blk
      assert_equal 45, find_result[:total].blk
    end

    def test_populates_pts
      assert_equal 1130, find_result[:total].pts
    end
  end
end
