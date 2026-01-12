require_relative "../../test_helper"

module NBA
  class LeagueGameLogConstantsTest < Minitest::Test
    cover LeagueGameLog

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueGameLog::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueGameLog::PLAYOFFS
    end

    def test_player_constant
      assert_equal "P", LeagueGameLog::PLAYER
    end

    def test_team_constant
      assert_equal "T", LeagueGameLog::TEAM
    end

    def test_league_game_log_constant
      assert_equal "LeagueGameLog", LeagueGameLog::LEAGUE_GAME_LOG
    end
  end
end
