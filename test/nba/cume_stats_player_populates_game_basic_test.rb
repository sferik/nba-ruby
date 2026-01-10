require_relative "../test_helper"
require_relative "cume_stats_player_populates_helper"

module NBA
  class CumeStatsPlayerPopulatesGameBasicTest < Minitest::Test
    include CumeStatsPlayerPopulatesHelper

    cover CumeStatsPlayer

    def setup
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def test_populates_game_game_id
      assert_equal "0022400001", find_result[:game_by_game].first.game_id
    end

    def test_populates_game_matchup
      assert_equal "GSW vs. LAL", find_result[:game_by_game].first.matchup
    end

    def test_populates_game_game_date
      assert_equal "2024-10-22", find_result[:game_by_game].first.game_date
    end

    def test_populates_game_vs_team_id
      assert_equal 1_610_612_747, find_result[:game_by_game].first.vs_team_id
    end

    def test_populates_game_vs_team_city
      assert_equal "Los Angeles", find_result[:game_by_game].first.vs_team_city
    end

    def test_populates_game_vs_team_name
      assert_equal "Lakers", find_result[:game_by_game].first.vs_team_name
    end

    def test_populates_game_min
      assert_equal 35, find_result[:game_by_game].first.min
    end

    def test_populates_game_sec
      assert_equal 42, find_result[:game_by_game].first.sec
    end
  end
end
