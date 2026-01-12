require_relative "../../test_helper"
require_relative "cume_stats_player_populates_helper"

module NBA
  class CumeStatsPlayerPopulatesTotalMaxTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_total_max_min
      assert_equal 35, find_result[:total].max_min
    end

    def test_populates_total_max_fgm
      assert_equal 10, find_result[:total].max_fgm
    end

    def test_populates_total_max_fga
      assert_equal 20, find_result[:total].max_fga
    end

    def test_populates_total_max_fg3m
      assert_equal 3, find_result[:total].max_fg3m
    end

    def test_populates_total_max_fg3a
      assert_equal 8, find_result[:total].max_fg3a
    end

    def test_populates_total_max_ftm
      assert_equal 7, find_result[:total].max_ftm
    end

    def test_populates_total_max_fta
      assert_equal 8, find_result[:total].max_fta
    end

    def test_populates_total_max_oreb
      assert_equal 2, find_result[:total].max_oreb
    end

    def test_populates_total_max_dreb
      assert_equal 6, find_result[:total].max_dreb
    end

    def test_populates_total_max_reb
      assert_equal 8, find_result[:total].max_reb
    end

    def test_populates_total_max_ast
      assert_equal 7, find_result[:total].max_ast
    end

    def test_populates_total_max_pf
      assert_equal 3, find_result[:total].max_pf
    end

    def test_populates_total_max_stl
      assert_equal 2, find_result[:total].max_stl
    end

    def test_populates_total_max_tov
      assert_equal 3, find_result[:total].max_tov
    end

    def test_populates_total_max_blk
      assert_equal 1, find_result[:total].max_blk
    end

    def test_populates_total_max_pts
      assert_equal 30, find_result[:total].max_pts
    end
  end
end
