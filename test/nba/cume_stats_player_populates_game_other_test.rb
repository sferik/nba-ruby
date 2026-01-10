require_relative "../test_helper"
require_relative "cume_stats_player_populates_helper"

module NBA
  class CumeStatsPlayerPopulatesGameOtherTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_game_oreb
      assert_equal 2, find_result[:game_by_game].first.oreb
    end

    def test_populates_game_dreb
      assert_equal 6, find_result[:game_by_game].first.dreb
    end

    def test_populates_game_reb
      assert_equal 8, find_result[:game_by_game].first.reb
    end

    def test_populates_game_ast
      assert_equal 5, find_result[:game_by_game].first.ast
    end

    def test_populates_game_pf
      assert_equal 3, find_result[:game_by_game].first.pf
    end

    def test_populates_game_stl
      assert_equal 2, find_result[:game_by_game].first.stl
    end

    def test_populates_game_tov
      assert_equal 3, find_result[:game_by_game].first.tov
    end

    def test_populates_game_blk
      assert_equal 1, find_result[:game_by_game].first.blk
    end

    def test_populates_game_pts
      assert_equal 30, find_result[:game_by_game].first.pts
    end
  end
end
