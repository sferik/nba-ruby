require_relative "cume_stats_team_populates_helper"

module NBA
  class CumeStatsTeamPopulatesTotalRecordTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_gp
      assert_equal 10, find_result[:total].gp
    end

    def test_populates_gs
      assert_equal 10, find_result[:total].gs
    end

    def test_populates_w
      assert_equal 8, find_result[:total].w
    end

    def test_populates_l
      assert_equal 2, find_result[:total].l
    end

    def test_populates_w_home
      assert_equal 5, find_result[:total].w_home
    end

    def test_populates_l_home
      assert_equal 1, find_result[:total].l_home
    end

    def test_populates_w_road
      assert_equal 3, find_result[:total].w_road
    end

    def test_populates_l_road
      assert_equal 1, find_result[:total].l_road
    end

    def test_populates_team_turnovers
      assert_equal 120, find_result[:total].team_turnovers
    end

    def test_populates_team_rebounds
      assert_equal 450, find_result[:total].team_rebounds
    end
  end
end
