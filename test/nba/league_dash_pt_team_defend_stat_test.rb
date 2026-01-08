require_relative "../test_helper"

module NBA
  class LeagueDashPtTeamDefendStatTest < Minitest::Test
    cover LeagueDashPtTeamDefendStat

    def test_objects_with_same_team_id_are_equal
      stat0 = LeagueDashPtTeamDefendStat.new(team_id: Team::GSW)
      stat1 = LeagueDashPtTeamDefendStat.new(team_id: Team::GSW)

      assert_equal stat0, stat1
    end

    def test_objects_with_different_team_id_are_not_equal
      stat0 = LeagueDashPtTeamDefendStat.new(team_id: Team::GSW)
      stat1 = LeagueDashPtTeamDefendStat.new(team_id: 1_610_612_747)

      refute_equal stat0, stat1
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = LeagueDashPtTeamDefendStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_team_returns_team_object_when_team_id_valid
      stat = LeagueDashPtTeamDefendStat.new(team_id: Team::GSW)

      result = stat.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end
  end
end
