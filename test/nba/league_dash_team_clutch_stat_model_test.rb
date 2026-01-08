require_relative "../test_helper"

module NBA
  class LeagueDashTeamClutchStatModelTest < Minitest::Test
    cover LeagueDashTeamClutchStat

    def test_objects_with_same_team_id_and_season_id_are_equal
      stat0 = LeagueDashTeamClutchStat.new(team_id: Team::GSW, season_id: "2024-25")
      stat1 = LeagueDashTeamClutchStat.new(team_id: Team::GSW, season_id: "2024-25")

      assert_equal stat0, stat1
    end

    def test_objects_with_different_team_id_are_not_equal
      stat0 = LeagueDashTeamClutchStat.new(team_id: Team::GSW, season_id: "2024-25")
      stat1 = LeagueDashTeamClutchStat.new(team_id: Team::LAL, season_id: "2024-25")

      refute_equal stat0, stat1
    end

    def test_objects_with_different_season_id_are_not_equal
      stat0 = LeagueDashTeamClutchStat.new(team_id: Team::GSW, season_id: "2024-25")
      stat1 = LeagueDashTeamClutchStat.new(team_id: Team::GSW, season_id: "2023-24")

      refute_equal stat0, stat1
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = LeagueDashTeamClutchStat.new(team_id: nil)

      assert_nil stat.team
    end

    def test_team_returns_team_object_when_team_id_valid
      stat = LeagueDashTeamClutchStat.new(team_id: Team::GSW)

      result = stat.team

      assert_instance_of Team, result
      assert_equal Team::GSW, result.id
    end
  end
end
