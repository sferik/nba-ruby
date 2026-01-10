require_relative "../test_helper"

module NBA
  class AssistTrackerMissingFg3KeysTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_missing_fg3m
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG3A FG3_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 15, 0.533]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.fg3m
      assert_equal 15, entry.fg3a
    end

    def test_all_handles_missing_fg3a
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG3M FG3_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 8, 0.533]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 8, entry.fg3m
      assert_nil entry.fg3a
    end

    def test_all_handles_missing_fg3_pct
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG3M FG3A],
                                rowSet: [[201_566, "Russell Westbrook", 8, 15]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 8, entry.fg3m
      assert_nil entry.fg3_pct
    end
  end
end
