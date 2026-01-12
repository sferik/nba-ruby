require_relative "../../test_helper"
require_relative "assist_tracker_entry_hydration_helper"

module NBA
  class AssistTrackerEntryPassToPlayerHydrationTest < Minitest::Test
    include AssistTrackerEntryHydrationHelper

    cover AssistTrackerEntry

    def test_pass_to_player_returns_hydrated_player
      stub_player_info_request(player_id: 202_695, name: "Kawhi Leonard")
      entry = AssistTrackerEntry.new(pass_to_player_id: 202_695)

      player = entry.pass_to_player

      assert_instance_of Player, player
    end

    def test_pass_to_player_returns_nil_when_pass_to_player_id_nil
      entry = AssistTrackerEntry.new(pass_to_player_id: nil)

      assert_nil entry.pass_to_player
    end
  end
end
