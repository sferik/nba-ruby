require_relative "../test_helper"

module NBA
  class TeamDetailModelTest < Minitest::Test
    cover TeamDetail

    def test_objects_with_same_team_id_are_equal
      detail0 = TeamDetail.new(team_id: Team::GSW)
      detail1 = TeamDetail.new(team_id: Team::GSW)

      assert_equal detail0, detail1
    end

    def test_objects_with_different_team_id_are_not_equal
      detail0 = TeamDetail.new(team_id: Team::GSW)
      detail1 = TeamDetail.new(team_id: Team::LAL)

      refute_equal detail0, detail1
    end

    def test_full_name_returns_combined_name
      detail = TeamDetail.new(city: "Golden State", nickname: "Warriors")

      assert_equal "Golden State Warriors", detail.full_name
    end

    def test_full_name_handles_nil_values
      detail = TeamDetail.new(city: nil, nickname: nil)

      assert_equal "", detail.full_name
    end

    def test_team_returns_nil_when_team_id_is_nil
      detail = TeamDetail.new(team_id: nil)

      assert_nil detail.team
    end

    def test_team_returns_team_object_when_team_id_valid
      detail = TeamDetail.new(team_id: Team::GSW)

      result = detail.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end
  end
end
