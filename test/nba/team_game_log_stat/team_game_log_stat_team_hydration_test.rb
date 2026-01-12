require_relative "../../test_helper"

module NBA
  class TeamGameLogStatTeamHydrationTest < Minitest::Test
    cover TeamGameLogStat

    def test_team_returns_team_object
      log = TeamGameLogStat.new(team_id: Team::GSW)

      team = log.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
      assert_equal "Golden State Warriors", team.full_name
    end

    def test_team_returns_nil_when_team_id_is_nil
      log = TeamGameLogStat.new(team_id: nil)

      assert_nil log.team
    end

    def test_team_returns_nil_for_invalid_team_id
      log = TeamGameLogStat.new(team_id: 999_999)

      assert_nil log.team
    end

    def test_team_finds_correct_team_by_id
      log = TeamGameLogStat.new(team_id: Team::LAL)

      team = log.team

      assert_equal "Los Angeles Lakers", team.full_name
    end
  end
end
