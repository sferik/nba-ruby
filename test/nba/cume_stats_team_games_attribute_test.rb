require_relative "../test_helper"
require_relative "cume_stats_team_games_test_helper"

module NBA
  class CumeStatsTeamGamesAttributeTest < Minitest::Test
    include CumeStatsTeamGamesTestHelper

    cover CumeStatsTeamGames

    def test_parses_matchup
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      assert_equal "LAL @ DEN", CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).first.matchup
    end

    def test_parses_game_id
      stub_request(:get, /cumestatsteamgames/).to_return(body: response.to_json)

      assert_equal 22_300_001, CumeStatsTeamGames.all(team: 1_610_612_747, season: 2023).first.game_id
    end
  end
end
