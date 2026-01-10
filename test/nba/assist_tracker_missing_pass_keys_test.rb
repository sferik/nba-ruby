require_relative "../test_helper"

module NBA
  class AssistTrackerMissingPassKeysTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_missing_pass_to
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION],
                                rowSet: [[201_566, "Russell Westbrook", Team::LAC, "LAC"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 201_566, entry.player_id
      assert_nil entry.pass_to
    end

    def test_all_handles_missing_pass_to_player_id
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION PASS_TO],
                                rowSet: [[201_566, "Russell Westbrook", Team::LAC, "LAC", "Kawhi Leonard"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal "Kawhi Leonard", entry.pass_to
      assert_nil entry.pass_to_player_id
    end

    def test_all_handles_missing_frequency
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME AST],
                                rowSet: [[201_566, "Russell Westbrook", 32]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.frequency
      assert_equal 32, entry.ast
    end

    def test_all_handles_missing_pass
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME AST],
                                rowSet: [[201_566, "Russell Westbrook", 32]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.pass
      assert_equal 32, entry.ast
    end

    def test_all_handles_missing_ast
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME PASS],
                                rowSet: [[201_566, "Russell Westbrook", 45]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 45, entry.pass
      assert_nil entry.ast
    end
  end
end
