require_relative "../../test_helper"
require_relative "assist_tracker_entry_hydration_helper"

module NBA
  class AssistTrackerEntryPlayerHydrationTest < Minitest::Test
    include AssistTrackerEntryHydrationHelper

    cover AssistTrackerEntry

    def test_player_returns_hydrated_player
      stub_player_info_request(player_id: 201_566, name: "Russell Westbrook")
      entry = AssistTrackerEntry.new(player_id: 201_566)

      player = entry.player

      assert_instance_of Player, player
    end

    def test_player_returns_nil_when_player_id_nil
      entry = AssistTrackerEntry.new(player_id: nil)

      assert_nil entry.player
    end
  end
end
