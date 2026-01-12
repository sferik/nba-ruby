require_relative "../../test_helper"

module NBA
  class LeagueSeasonMatchupStatAttributesTest < Minitest::Test
    cover LeagueSeasonMatchupStat

    def test_matchup_ast_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_ast: 3.0)

      assert_in_delta 3.0, stat.matchup_ast
    end

    def test_matchup_tov_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_tov: 1.0)

      assert_in_delta 1.0, stat.matchup_tov
    end

    def test_matchup_blk_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_blk: 0.5)

      assert_in_delta 0.5, stat.matchup_blk
    end

    def test_matchup_fgm_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_fgm: 6.0)

      assert_in_delta 6.0, stat.matchup_fgm
    end

    def test_matchup_fga_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_fga: 14.0)

      assert_in_delta 14.0, stat.matchup_fga
    end

    def test_matchup_fg_pct_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_fg_pct: 0.429)

      assert_in_delta 0.429, stat.matchup_fg_pct
    end

    def test_matchup_fg3m_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_fg3m: 2.0)

      assert_in_delta 2.0, stat.matchup_fg3m
    end

    def test_matchup_fg3a_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_fg3a: 6.0)

      assert_in_delta 6.0, stat.matchup_fg3a
    end

    def test_matchup_fg3_pct_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_fg3_pct: 0.333)

      assert_in_delta 0.333, stat.matchup_fg3_pct
    end

    def test_help_blk_attribute
      stat = LeagueSeasonMatchupStat.new(help_blk: 0.0)

      assert_in_delta 0.0, stat.help_blk
    end

    def test_help_fgm_attribute
      stat = LeagueSeasonMatchupStat.new(help_fgm: 1.0)

      assert_in_delta 1.0, stat.help_fgm
    end

    def test_help_fga_attribute
      stat = LeagueSeasonMatchupStat.new(help_fga: 2.0)

      assert_in_delta 2.0, stat.help_fga
    end

    def test_help_fg_pct_attribute
      stat = LeagueSeasonMatchupStat.new(help_fg_pct: 0.500)

      assert_in_delta 0.500, stat.help_fg_pct
    end

    def test_matchup_ftm_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_ftm: 4.0)

      assert_in_delta 4.0, stat.matchup_ftm
    end

    def test_matchup_fta_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_fta: 5.0)

      assert_in_delta 5.0, stat.matchup_fta
    end

    def test_sfl_attribute
      stat = LeagueSeasonMatchupStat.new(sfl: 2.0)

      assert_in_delta 2.0, stat.sfl
    end
  end
end
