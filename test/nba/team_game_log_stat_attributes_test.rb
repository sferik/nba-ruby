require_relative "../test_helper"

module NBA
  class TeamGameLogStatAttributesTest < Minitest::Test
    cover TeamGameLogStat

    def test_season_year_attribute
      log = TeamGameLogStat.new(season_year: "2024-25")

      assert_equal "2024-25", log.season_year
    end

    def test_team_id_attribute
      log = TeamGameLogStat.new(team_id: Team::GSW)

      assert_equal Team::GSW, log.team_id
    end

    def test_team_abbreviation_attribute
      log = TeamGameLogStat.new(team_abbreviation: "GSW")

      assert_equal "GSW", log.team_abbreviation
    end

    def test_team_name_attribute
      log = TeamGameLogStat.new(team_name: "Warriors")

      assert_equal "Warriors", log.team_name
    end

    def test_game_id_attribute
      log = TeamGameLogStat.new(game_id: "0022400001")

      assert_equal "0022400001", log.game_id
    end

    def test_game_date_attribute
      log = TeamGameLogStat.new(game_date: "2024-10-22T00:00:00")

      assert_equal "2024-10-22T00:00:00", log.game_date
    end

    def test_matchup_attribute
      log = TeamGameLogStat.new(matchup: "GSW vs. LAL")

      assert_equal "GSW vs. LAL", log.matchup
    end

    def test_wl_attribute
      log = TeamGameLogStat.new(wl: "W")

      assert_equal "W", log.wl
    end

    def test_min_attribute
      log = TeamGameLogStat.new(min: 240)

      assert_equal 240, log.min
    end

    def test_fgm_attribute
      log = TeamGameLogStat.new(fgm: 42)

      assert_equal 42, log.fgm
    end

    def test_fga_attribute
      log = TeamGameLogStat.new(fga: 88)

      assert_equal 88, log.fga
    end

    def test_fg_pct_attribute
      log = TeamGameLogStat.new(fg_pct: 0.477)

      assert_in_delta 0.477, log.fg_pct
    end

    def test_fg3m_attribute
      log = TeamGameLogStat.new(fg3m: 15)

      assert_equal 15, log.fg3m
    end

    def test_fg3a_attribute
      log = TeamGameLogStat.new(fg3a: 38)

      assert_equal 38, log.fg3a
    end

    def test_fg3_pct_attribute
      log = TeamGameLogStat.new(fg3_pct: 0.395)

      assert_in_delta 0.395, log.fg3_pct
    end
  end
end
