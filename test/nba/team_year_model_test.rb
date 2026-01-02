require_relative "../test_helper"

module NBA
  class TeamYearModelTest < Minitest::Test
    cover TeamYear

    def test_objects_with_same_team_id_and_year_are_equal
      year0 = TeamYear.new(team_id: Team::GSW, year: 2024)
      year1 = TeamYear.new(team_id: Team::GSW, year: 2024)

      assert_equal year0, year1
    end

    def test_objects_with_different_team_id_are_not_equal
      year0 = TeamYear.new(team_id: Team::GSW, year: 2024)
      year1 = TeamYear.new(team_id: 1_610_612_747, year: 2024)

      refute_equal year0, year1
    end

    def test_objects_with_different_year_are_not_equal
      year0 = TeamYear.new(team_id: Team::GSW, year: 2024)
      year1 = TeamYear.new(team_id: Team::GSW, year: 2023)

      refute_equal year0, year1
    end

    def test_team_returns_nil_when_team_id_is_nil
      year = TeamYear.new(team_id: nil)

      assert_nil year.team
    end

    def test_team_returns_team_object_when_team_id_valid
      year = TeamYear.new(team_id: Team::GSW)

      result = year.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end

    def test_season_returns_formatted_season_string
      year = TeamYear.new(year: 2024)

      assert_equal "2024-25", year.season
    end

    def test_season_handles_nil_year
      year = TeamYear.new(year: nil)

      assert_nil year.season
    end
  end
end
