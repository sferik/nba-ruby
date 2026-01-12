require_relative "../../test_helper"

module NBA
  class LeaguePlayerOnDetailsConstantsTest < Minitest::Test
    cover LeaguePlayerOnDetails

    def test_players_on_court_constant
      assert_equal "PlayersOnCourtLeaguePlayerDetails", LeaguePlayerOnDetails::PLAYERS_ON_COURT
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeaguePlayerOnDetails::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeaguePlayerOnDetails::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeaguePlayerOnDetails::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeaguePlayerOnDetails::TOTALS
    end

    def test_base_constant
      assert_equal "Base", LeaguePlayerOnDetails::BASE
    end
  end
end
