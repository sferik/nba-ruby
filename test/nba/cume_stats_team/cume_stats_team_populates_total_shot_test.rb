require_relative "cume_stats_team_populates_helper"

module NBA
  class CumeStatsTeamPopulatesTotalShotTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_fgm
      assert_equal 400, find_result[:total].fgm
    end

    def test_populates_fga
      assert_equal 850, find_result[:total].fga
    end

    def test_populates_fg_pct
      assert_in_delta(0.471, find_result[:total].fg_pct)
    end

    def test_populates_fg3m
      assert_equal 150, find_result[:total].fg3m
    end

    def test_populates_fg3a
      assert_equal 400, find_result[:total].fg3a
    end

    def test_populates_fg3_pct
      assert_in_delta(0.375, find_result[:total].fg3_pct)
    end

    def test_populates_ftm
      assert_equal 180, find_result[:total].ftm
    end

    def test_populates_fta
      assert_equal 220, find_result[:total].fta
    end

    def test_populates_ft_pct
      assert_in_delta(0.818, find_result[:total].ft_pct)
    end
  end
end
