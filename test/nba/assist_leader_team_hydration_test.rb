require_relative "assist_leader_hydration_helper"

module NBA
  class AssistLeaderTeamHydrationTest < Minitest::Test
    include AssistLeaderHydrationHelper

    cover AssistLeader

    def test_team_returns_hydrated_team
      stub_team_details_request
      leader = AssistLeader.new(team_id: Team::LAC)

      team = leader.team

      assert_instance_of Team, team
    end

    def test_team_returns_nil_when_team_id_nil
      leader = AssistLeader.new(team_id: nil)

      assert_nil leader.team
    end
  end
end
