require_relative "../test_helper"
require_relative "cume_stats_player_populates_helper"

module NBA
  class CumeStatsPlayerPopulatesTotalShotTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_total_fgm
      assert_equal 18, find_result[:total].fgm
    end

    def test_populates_total_fga
      assert_equal 38, find_result[:total].fga
    end

    def test_populates_total_fg_pct
      assert_in_delta 0.474, find_result[:total].fg_pct
    end

    def test_populates_total_fg3m
      assert_equal 5, find_result[:total].fg3m
    end

    def test_populates_total_fg3a
      assert_equal 15, find_result[:total].fg3a
    end

    def test_populates_total_fg3_pct
      assert_in_delta 0.333, find_result[:total].fg3_pct
    end

    def test_populates_total_ftm
      assert_equal 12, find_result[:total].ftm
    end

    def test_populates_total_fta
      assert_equal 14, find_result[:total].fta
    end

    def test_populates_total_ft_pct
      assert_in_delta 0.857, find_result[:total].ft_pct
    end
  end
end
