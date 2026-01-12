require_relative "../../test_helper"

module NBA
  class AllTimeLeadersConstantsTest < Minitest::Test
    cover AllTimeLeaders

    def test_pts_constant
      assert_equal "PTS", AllTimeLeaders::PTS
    end

    def test_reb_constant
      assert_equal "REB", AllTimeLeaders::REB
    end

    def test_ast_constant
      assert_equal "AST", AllTimeLeaders::AST
    end

    def test_stl_constant
      assert_equal "STL", AllTimeLeaders::STL
    end

    def test_blk_constant
      assert_equal "BLK", AllTimeLeaders::BLK
    end

    def test_fgm_constant
      assert_equal "FGM", AllTimeLeaders::FGM
    end

    def test_fga_constant
      assert_equal "FGA", AllTimeLeaders::FGA
    end

    def test_fg3m_constant
      assert_equal "FG3M", AllTimeLeaders::FG3M
    end

    def test_fg3a_constant
      assert_equal "FG3A", AllTimeLeaders::FG3A
    end

    def test_ftm_constant
      assert_equal "FTM", AllTimeLeaders::FTM
    end

    def test_fta_constant
      assert_equal "FTA", AllTimeLeaders::FTA
    end

    def test_gp_constant
      assert_equal "GP", AllTimeLeaders::GP
    end

    def test_tov_constant
      assert_equal "TOV", AllTimeLeaders::TOV
    end

    def test_pf_constant
      assert_equal "PF", AllTimeLeaders::PF
    end

    def test_oreb_constant
      assert_equal "OREB", AllTimeLeaders::OREB
    end

    def test_dreb_constant
      assert_equal "DREB", AllTimeLeaders::DREB
    end

    def test_regular_season_constant
      assert_equal "Regular Season", AllTimeLeaders::REGULAR_SEASON
    end

    def test_playoffs_constant
      assert_equal "Playoffs", AllTimeLeaders::PLAYOFFS
    end

    def test_totals_constant
      assert_equal "Totals", AllTimeLeaders::TOTALS
    end

    def test_per_game_constant
      assert_equal "PerGame", AllTimeLeaders::PER_GAME
    end
  end
end
