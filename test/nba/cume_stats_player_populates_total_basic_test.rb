require_relative "../test_helper"
require_relative "cume_stats_player_populates_helper"

module NBA
  class CumeStatsPlayerPopulatesTotalBasicTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_total_player_id
      assert_equal 201_939, find_result[:total].player_id
    end

    def test_populates_total_player_name
      assert_equal "Stephen Curry", find_result[:total].player_name
    end

    def test_populates_total_jersey_num
      assert_equal "30", find_result[:total].jersey_num
    end

    def test_populates_total_season
      assert_equal "2024-25", find_result[:total].season
    end

    def test_populates_total_gp
      assert_equal 2, find_result[:total].gp
    end

    def test_populates_total_gs
      assert_equal 2, find_result[:total].gs
    end

    def test_populates_total_actual_minutes
      assert_equal 67, find_result[:total].actual_minutes
    end

    def test_populates_total_actual_seconds
      assert_equal 57, find_result[:total].actual_seconds
    end
  end
end
