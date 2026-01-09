require_relative "../test_helper"

module NBA
  class CumeStatsTeamTotalModelTest < Minitest::Test
    cover CumeStatsTeamTotal

    def test_objects_with_same_team_id_are_equal
      total0 = CumeStatsTeamTotal.new(team_id: Team::GSW)
      total1 = CumeStatsTeamTotal.new(team_id: Team::GSW)

      assert_equal total0, total1
    end

    def test_objects_with_different_team_id_are_not_equal
      total0 = CumeStatsTeamTotal.new(team_id: Team::GSW)
      total1 = CumeStatsTeamTotal.new(team_id: Team::LAL)

      refute_equal total0, total1
    end

    def test_team_returns_nil_when_team_id_is_nil
      total = CumeStatsTeamTotal.new(team_id: nil)

      assert_nil total.team
    end

    def test_team_returns_team_object_when_team_id_valid
      total = CumeStatsTeamTotal.new(team_id: Team::GSW)

      result = total.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end
  end
end
