require_relative "../../test_helper"

module NBA
  class AssistTrackerMissingFgKeysTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_missing_fg_m
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FGA FG_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 45, 0.622]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.fg_m
      assert_equal 45, entry.fg_a
    end

    def test_all_handles_missing_fg_a
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FGM FG_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 28, 0.622]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 28, entry.fg_m
      assert_nil entry.fg_a
    end

    def test_all_handles_missing_fg_pct
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FGM FGA],
                                rowSet: [[201_566, "Russell Westbrook", 28, 45]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 28, entry.fg_m
      assert_nil entry.fg_pct
    end
  end
end
