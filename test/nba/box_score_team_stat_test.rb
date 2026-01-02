require_relative "../test_helper"

module NBA
  class BoxScoreTeamStatTest < Minitest::Test
    cover BoxScoreTeamStat

    def test_objects_with_same_game_id_and_team_id_are_equal
      stat0 = BoxScoreTeamStat.new(game_id: "001", team_id: Team::GSW)
      stat1 = BoxScoreTeamStat.new(game_id: "001", team_id: Team::GSW)

      assert_equal stat0, stat1
    end

    def test_objects_with_different_team_id_are_not_equal
      stat0 = BoxScoreTeamStat.new(game_id: "001", team_id: Team::GSW)
      stat1 = BoxScoreTeamStat.new(game_id: "001", team_id: Team::LAL)

      refute_equal stat0, stat1
    end

    def test_team_returns_team_object
      stat = BoxScoreTeamStat.new(team_id: Team::GSW)

      team = stat.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      stat = BoxScoreTeamStat.new(team_id: nil)

      assert_nil stat.team
    end
  end
end
