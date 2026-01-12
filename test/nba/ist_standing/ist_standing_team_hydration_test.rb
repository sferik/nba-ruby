require_relative "ist_standing_test_helper"

module NBA
  class IstStandingTeamHydrationTest < Minitest::Test
    include IstStandingTestHelper

    cover IstStanding

    def test_team_returns_hydrated_team
      stub_team_details_request
      standing = IstStanding.new(team_id: Team::LAL)

      team = standing.team

      assert_instance_of Team, team
    end

    def test_team_returns_nil_when_team_id_nil
      standing = IstStanding.new(team_id: nil)

      assert_nil standing.team
    end
  end
end
