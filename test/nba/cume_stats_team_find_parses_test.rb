require_relative "cume_stats_team_test_helper"

module NBA
  class CumeStatsTeamFindParsesTest < Minitest::Test
    include CumeStatsTeamTestHelper

    cover CumeStatsTeam

    def test_find_parses_game_by_game_stats_successfully
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_equal 1, result[:game_by_game].size
      assert_equal 201_939, result[:game_by_game].first.person_id
      assert_equal "Stephen Curry", result[:game_by_game].first.player_name
    end

    def test_find_parses_total_stats_successfully
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_equal Team::GSW, result[:total].team_id
      assert_equal "Golden State", result[:total].city
      assert_equal "Warriors", result[:total].nickname
    end
  end
end
