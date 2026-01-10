require_relative "../test_helper"

module NBA
  class LeagueHustleStatsTeamStatHydrationTest < Minitest::Test
    cover LeagueHustleStatsTeamStat

    def test_team_returns_team_object
      stat = LeagueHustleStatsTeamStat.new(team_id: Team::GSW)

      assert_instance_of Team, stat.team
    end

    def test_team_uses_team_id_for_lookup
      stat = LeagueHustleStatsTeamStat.new(team_id: Team::GSW)

      assert_equal Team::GSW, stat.team.id
    end

    def test_team_returns_nil_for_invalid_team_id
      stat = LeagueHustleStatsTeamStat.new(team_id: 999_999_999)

      assert_nil stat.team
    end
  end
end
