require_relative "../test_helper"

module NBA
  class LeagueLineupVizConstantsTest < Minitest::Test
    cover LeagueLineupViz

    def test_league_lineup_viz_constant
      assert_equal "LeagueLineupViz", LeagueLineupViz::LEAGUE_LINEUP_VIZ
    end

    def test_regular_season_constant
      assert_equal "Regular Season", LeagueLineupViz::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", LeagueLineupViz::PLAYOFFS
    end

    def test_per_game_constant
      assert_equal "PerGame", LeagueLineupViz::PER_GAME
    end

    def test_totals_constant
      assert_equal "Totals", LeagueLineupViz::TOTALS
    end

    def test_base_constant
      assert_equal "Base", LeagueLineupViz::BASE
    end

    def test_advanced_constant
      assert_equal "Advanced", LeagueLineupViz::ADVANCED
    end

    def test_five_man_constant
      assert_equal 5, LeagueLineupViz::FIVE_MAN
    end

    def test_four_man_constant
      assert_equal 4, LeagueLineupViz::FOUR_MAN
    end

    def test_three_man_constant
      assert_equal 3, LeagueLineupViz::THREE_MAN
    end

    def test_two_man_constant
      assert_equal 2, LeagueLineupViz::TWO_MAN
    end
  end
end
