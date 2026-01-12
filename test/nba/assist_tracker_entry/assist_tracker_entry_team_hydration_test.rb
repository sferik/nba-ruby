require_relative "../../test_helper"
require_relative "assist_tracker_entry_hydration_helper"

module NBA
  class AssistTrackerEntryTeamHydrationTest < Minitest::Test
    include AssistTrackerEntryHydrationHelper

    cover AssistTrackerEntry

    def test_team_returns_hydrated_team
      stub_team_details_request
      entry = AssistTrackerEntry.new(team_id: Team::LAC)

      team = entry.team

      assert_instance_of Team, team
    end

    def test_team_returns_nil_when_team_id_nil
      entry = AssistTrackerEntry.new(team_id: nil)

      assert_nil entry.team
    end
  end
end
