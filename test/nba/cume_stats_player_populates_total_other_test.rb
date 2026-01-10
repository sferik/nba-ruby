require_relative "../test_helper"
require_relative "cume_stats_player_populates_helper"

module NBA
  class CumeStatsPlayerPopulatesTotalOtherTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_total_oreb
      assert_equal 3, find_result[:total].oreb
    end

    def test_populates_total_dreb
      assert_equal 11, find_result[:total].dreb
    end

    def test_populates_total_tot_reb
      assert_equal 14, find_result[:total].tot_reb
    end

    def test_populates_total_ast
      assert_equal 12, find_result[:total].ast
    end

    def test_populates_total_pf
      assert_equal 5, find_result[:total].pf
    end

    def test_populates_total_stl
      assert_equal 3, find_result[:total].stl
    end

    def test_populates_total_tov
      assert_equal 5, find_result[:total].tov
    end

    def test_populates_total_blk
      assert_equal 1, find_result[:total].blk
    end

    def test_populates_total_pts
      assert_equal 53, find_result[:total].pts
    end
  end
end
