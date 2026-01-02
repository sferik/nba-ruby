require_relative "../test_helper"

module NBA
  class TeamYearStatModelTest < Minitest::Test
    cover TeamYearStat

    def test_objects_with_same_team_id_and_year_are_equal
      stat0 = TeamYearStat.new(team_id: Team::GSW, year: "2024-25")
      stat1 = TeamYearStat.new(team_id: Team::GSW, year: "2024-25")

      assert_equal stat0, stat1
    end

    def test_objects_with_different_year_are_not_equal
      stat0 = TeamYearStat.new(team_id: Team::GSW, year: "2024-25")
      stat1 = TeamYearStat.new(team_id: Team::GSW, year: "2023-24")

      refute_equal stat0, stat1
    end

    def test_full_name_returns_combined_name
      stat = TeamYearStat.new(team_city: "Golden State", team_name: "Warriors")

      assert_equal "Golden State Warriors", stat.full_name
    end

    def test_full_name_handles_nil_values
      stat = TeamYearStat.new(team_city: nil, team_name: nil)

      assert_equal "", stat.full_name
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = TeamYearStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_team_returns_team_object_when_team_id_valid
      stat = TeamYearStat.new(team_id: Team::GSW)

      result = stat.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end
  end
end
