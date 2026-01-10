require_relative "../test_helper"

module NBA
  class AssistTrackerMissingFg2KeysTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_missing_fg2m
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG2A FG2_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 30, 0.667]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.fg2m
      assert_equal 30, entry.fg2a
    end

    def test_all_handles_missing_fg2a
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG2M FG2_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 20, 0.667]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 20, entry.fg2m
      assert_nil entry.fg2a
    end

    def test_all_handles_missing_fg2_pct
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG2M FG2A],
                                rowSet: [[201_566, "Russell Westbrook", 20, 30]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 20, entry.fg2m
      assert_nil entry.fg2_pct
    end
  end
end
