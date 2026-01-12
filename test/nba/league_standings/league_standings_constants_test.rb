require_relative "../../test_helper"

module NBA
  class LeagueStandingsConstantsTest < Minitest::Test
    cover LeagueStandings

    def test_standings_constant
      assert_equal "Standings", LeagueStandings::STANDINGS
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueStandings::REGULAR_SEASON
    end
  end
end
