require_relative "../../test_helper"
require_relative "cume_stats_player_populates_helper"

module NBA
  class CumeStatsPlayerPopulatesTotalAvgTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_total_avg_min
      assert_in_delta 33.5, find_result[:total].avg_min
    end

    def test_populates_total_avg_sec
      assert_in_delta 28.5, find_result[:total].avg_sec
    end

    def test_populates_total_avg_fgm
      assert_in_delta 9.0, find_result[:total].avg_fgm
    end

    def test_populates_total_avg_fga
      assert_in_delta 19.0, find_result[:total].avg_fga
    end

    def test_populates_total_avg_fg3m
      assert_in_delta 2.5, find_result[:total].avg_fg3m
    end

    def test_populates_total_avg_fg3a
      assert_in_delta 7.5, find_result[:total].avg_fg3a
    end

    def test_populates_total_avg_ftm
      assert_in_delta 6.0, find_result[:total].avg_ftm
    end

    def test_populates_total_avg_fta
      assert_in_delta 7.0, find_result[:total].avg_fta
    end

    def test_populates_total_avg_oreb
      assert_in_delta 1.5, find_result[:total].avg_oreb
    end

    def test_populates_total_avg_dreb
      assert_in_delta 5.5, find_result[:total].avg_dreb
    end

    def test_populates_total_avg_tot_reb
      assert_in_delta 7.0, find_result[:total].avg_tot_reb
    end

    def test_populates_total_avg_ast
      assert_in_delta 6.0, find_result[:total].avg_ast
    end

    def test_populates_total_avg_pf
      assert_in_delta 2.5, find_result[:total].avg_pf
    end

    def test_populates_total_avg_stl
      assert_in_delta 1.5, find_result[:total].avg_stl
    end

    def test_populates_total_avg_tov
      assert_in_delta 2.5, find_result[:total].avg_tov
    end

    def test_populates_total_avg_blk
      assert_in_delta 0.5, find_result[:total].avg_blk
    end

    def test_populates_total_avg_pts
      assert_in_delta 26.5, find_result[:total].avg_pts
    end
  end
end
