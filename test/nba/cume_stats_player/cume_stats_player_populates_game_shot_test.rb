require_relative "../../test_helper"
require_relative "cume_stats_player_populates_helper"

module NBA
  class CumeStatsPlayerPopulatesGameShotTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_game_fgm
      assert_equal 10, find_result[:game_by_game].first.fgm
    end

    def test_populates_game_fga
      assert_equal 20, find_result[:game_by_game].first.fga
    end

    def test_populates_game_fg_pct
      assert_in_delta 0.500, find_result[:game_by_game].first.fg_pct
    end

    def test_populates_game_fg3m
      assert_equal 3, find_result[:game_by_game].first.fg3m
    end

    def test_populates_game_fg3a
      assert_equal 8, find_result[:game_by_game].first.fg3a
    end

    def test_populates_game_fg3_pct
      assert_in_delta 0.375, find_result[:game_by_game].first.fg3_pct
    end

    def test_populates_game_ftm
      assert_equal 7, find_result[:game_by_game].first.ftm
    end

    def test_populates_game_fta
      assert_equal 8, find_result[:game_by_game].first.fta
    end

    def test_populates_game_ft_pct
      assert_in_delta 0.875, find_result[:game_by_game].first.ft_pct
    end
  end
end
