require_relative "cume_stats_team_populates_helper"

module NBA
  class CumeStatsTeamPopulatesPlayerShotTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_fgm
      assert_equal 100, find_result[:game_by_game].first.fgm
    end

    def test_populates_fga
      assert_equal 200, find_result[:game_by_game].first.fga
    end

    def test_populates_fg_pct
      assert_in_delta(0.500, find_result[:game_by_game].first.fg_pct)
    end

    def test_populates_fg3m
      assert_equal 40, find_result[:game_by_game].first.fg3m
    end

    def test_populates_fg3a
      assert_equal 100, find_result[:game_by_game].first.fg3a
    end

    def test_populates_fg3_pct
      assert_in_delta(0.400, find_result[:game_by_game].first.fg3_pct)
    end

    def test_populates_ftm
      assert_equal 80, find_result[:game_by_game].first.ftm
    end

    def test_populates_fta
      assert_equal 90, find_result[:game_by_game].first.fta
    end

    def test_populates_ft_pct
      assert_in_delta(0.889, find_result[:game_by_game].first.ft_pct)
    end
  end
end
