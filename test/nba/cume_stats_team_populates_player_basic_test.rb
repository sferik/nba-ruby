require_relative "cume_stats_team_populates_helper"

module NBA
  class CumeStatsTeamPopulatesPlayerBasicTest < Minitest::Test
    include CumeStatsTeamPopulatesHelper

    cover CumeStatsTeam

    def setup
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
    end

    def test_populates_gp
      assert_equal 10, find_result[:game_by_game].first.gp
    end

    def test_populates_gs
      assert_equal 10, find_result[:game_by_game].first.gs
    end

    def test_populates_actual_minutes
      assert_equal 350, find_result[:game_by_game].first.actual_minutes
    end

    def test_populates_actual_seconds
      assert_equal 21_000, find_result[:game_by_game].first.actual_seconds
    end

    def test_populates_jersey_num
      assert_equal "30", find_result[:game_by_game].first.jersey_num
    end

    def test_populates_player_team_id
      assert_equal Team::GSW, find_result[:game_by_game].first.team_id
    end
  end
end
