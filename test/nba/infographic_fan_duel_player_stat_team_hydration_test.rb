require_relative "infographic_fan_duel_player_stat_hydration_helper"

module NBA
  class InfographicFanDuelPlayerStatTeamHydrationTest < Minitest::Test
    include InfographicFanDuelPlayerStatHydrationHelper

    cover InfographicFanDuelPlayerStat

    def test_team_returns_hydrated_team
      stub_team_details_request
      stat = InfographicFanDuelPlayerStat.new(team_id: Team::GSW)

      team = stat.team

      assert_instance_of Team, team
    end

    def test_team_returns_nil_when_team_id_nil
      stat = InfographicFanDuelPlayerStat.new(team_id: nil)

      assert_nil stat.team
    end
  end
end
