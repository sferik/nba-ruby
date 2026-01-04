require_relative "../test_helper"

module NBA
  class TeamDashboardStatTest < Minitest::Test
    cover TeamDashboardStat

    def test_equality_based_on_team_id_and_group_value
      stat1 = TeamDashboardStat.new(team_id: Team::GSW, group_value: "Overall")
      stat2 = TeamDashboardStat.new(team_id: Team::GSW, group_value: "Overall")
      stat3 = TeamDashboardStat.new(team_id: Team::GSW, group_value: "Home")
      stat4 = TeamDashboardStat.new(team_id: Team::LAL, group_value: "Overall")

      assert_equal stat1, stat2
      refute_equal stat1, stat3
      refute_equal stat1, stat4
    end

    def test_team_returns_team_object
      stat = TeamDashboardStat.new(team_id: Team::GSW)

      team = stat.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_identity_attributes_assignable
      stat = sample_stat

      assert_equal "OverallTeamDashboard", stat.group_set
      assert_equal "Overall", stat.group_value
      assert_equal Team::GSW, stat.team_id
      assert_equal 82, stat.gp
      assert_in_delta 48.0, stat.min
    end

    def test_record_attributes_assignable
      stat = sample_stat

      assert_equal 50, stat.w
      assert_equal 32, stat.l
      assert_in_delta 0.610, stat.w_pct
    end

    private

    def sample_stat
      TeamDashboardStat.new(
        group_set: "OverallTeamDashboard", group_value: "Overall", team_id: Team::GSW,
        gp: 82, w: 50, l: 32, w_pct: 0.610, min: 48.0
      )
    end
  end
end
