require_relative "dunk_score_leader_hydration_helper"

module NBA
  class DunkScoreLeaderTeamHydrationTest < Minitest::Test
    include DunkScoreLeaderHydrationHelper

    cover DunkScoreLeader

    def test_team_returns_hydrated_team
      leader = DunkScoreLeader.new(team_id: Team::ORL)

      team = leader.team

      assert_instance_of Team, team
    end

    def test_team_returns_nil_when_team_id_nil
      leader = DunkScoreLeader.new(team_id: nil)

      assert_nil leader.team
    end
  end
end
