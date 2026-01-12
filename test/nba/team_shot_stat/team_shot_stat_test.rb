require_relative "../../test_helper"

module NBA
  class TeamShotStatTest < Minitest::Test
    cover TeamShotStat

    def test_has_team_id_attribute
      stat = TeamShotStat.new(team_id: 1_610_612_744)

      assert_equal 1_610_612_744, stat.team_id
    end

    def test_has_team_name_attribute
      stat = TeamShotStat.new(team_name: "Golden State Warriors")

      assert_equal "Golden State Warriors", stat.team_name
    end

    def test_has_team_abbreviation_attribute
      stat = TeamShotStat.new(team_abbreviation: "GSW")

      assert_equal "GSW", stat.team_abbreviation
    end

    def test_has_sort_order_attribute
      stat = TeamShotStat.new(sort_order: 1)

      assert_equal 1, stat.sort_order
    end

    def test_has_g_attribute
      stat = TeamShotStat.new(g: 82)

      assert_equal 82, stat.g
    end

    def test_has_shot_type_attribute
      stat = TeamShotStat.new(shot_type: "Catch and Shoot")

      assert_equal "Catch and Shoot", stat.shot_type
    end

    def test_has_fga_frequency_attribute
      stat = TeamShotStat.new(fga_frequency: 0.35)

      assert_in_delta 0.35, stat.fga_frequency
    end

    def test_has_fgm_attribute
      stat = TeamShotStat.new(fgm: 7.2)

      assert_in_delta 7.2, stat.fgm
    end

    def test_has_fga_attribute
      stat = TeamShotStat.new(fga: 15.3)

      assert_in_delta 15.3, stat.fga
    end

    def test_has_fg_pct_attribute
      stat = TeamShotStat.new(fg_pct: 0.472)

      assert_in_delta 0.472, stat.fg_pct
    end

    def test_has_efg_pct_attribute
      stat = TeamShotStat.new(efg_pct: 0.561)

      assert_in_delta 0.561, stat.efg_pct
    end

    def test_has_fg2a_frequency_attribute
      stat = TeamShotStat.new(fg2a_frequency: 0.45)

      assert_in_delta 0.45, stat.fg2a_frequency
    end

    def test_has_fg2m_attribute
      stat = TeamShotStat.new(fg2m: 4.1)

      assert_in_delta 4.1, stat.fg2m
    end

    def test_has_fg2a_attribute
      stat = TeamShotStat.new(fg2a: 7.8)

      assert_in_delta 7.8, stat.fg2a
    end

    def test_has_fg2_pct_attribute
      stat = TeamShotStat.new(fg2_pct: 0.526)

      assert_in_delta 0.526, stat.fg2_pct
    end

    def test_has_fg3a_frequency_attribute
      stat = TeamShotStat.new(fg3a_frequency: 0.55)

      assert_in_delta 0.55, stat.fg3a_frequency
    end
  end
end
