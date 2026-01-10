require_relative "../test_helper"

module NBA
  class AssistTrackerMissingPlayerKeysTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_missing_player_id
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_NAME TEAM_ID TEAM_ABBREVIATION PASS_TO],
                                rowSet: [["Russell Westbrook", Team::LAC, "LAC", "Kawhi Leonard"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.player_id
      assert_equal "Russell Westbrook", entry.player_name
    end

    def test_all_handles_missing_player_name
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID TEAM_ID TEAM_ABBREVIATION PASS_TO],
                                rowSet: [[201_566, Team::LAC, "LAC", "Kawhi Leonard"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 201_566, entry.player_id
      assert_nil entry.player_name
    end

    def test_all_handles_missing_team_id
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME TEAM_ABBREVIATION PASS_TO],
                                rowSet: [[201_566, "Russell Westbrook", "LAC", "Kawhi Leonard"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.team_id
      assert_equal "LAC", entry.team_abbreviation
    end

    def test_all_handles_missing_team_abbreviation
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID PASS_TO],
                                rowSet: [[201_566, "Russell Westbrook", Team::LAC, "Kawhi Leonard"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal Team::LAC, entry.team_id
      assert_nil entry.team_abbreviation
    end
  end
end
