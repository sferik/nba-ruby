require_relative "../test_helper"

module NBA
  class AssistTrackerEdgeCasesTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_nil_response
      stub_request(:get, /assisttracker/).to_return(body: nil)

      result = AssistTracker.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /assisttracker/).to_return(body: {resultSets: []}.to_json)

      result = AssistTracker.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      result = AssistTracker.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "AssistTracker", headers: %w[PLAYER_ID PLAYER_NAME], rowSet: []}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      result = AssistTracker.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_selects_correct_result_set_from_multiple
      stub_request(:get, /assisttracker/).to_return(body: multiple_result_sets_response.to_json)

      entry = AssistTracker.all.first

      assert_equal 201_566, entry.player_id
      assert_equal "Russell Westbrook", entry.player_name
    end

    def test_all_default_league_is_nba
      stub_request(:get, /assisttracker.*LeagueID=00/)
        .to_return(body: {resultSets: [{name: "AssistTracker", headers: %w[PLAYER_ID], rowSet: [[201_566]]}]}.to_json)

      AssistTracker.all

      assert_requested :get, /assisttracker.*LeagueID=00/
    end

    private

    def multiple_result_sets_response
      {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "AssistTracker", headers: assist_tracker_headers, rowSet: [assist_tracker_row]}
      ]}
    end

    def assist_tracker_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION PASS_TO PASS_TO_PLAYER_ID
        FREQUENCY PASS AST FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT]
    end

    def assist_tracker_row
      [201_566, "Russell Westbrook", Team::LAC, "LAC", "Kawhi Leonard", 202_695,
        0.15, 300, 150, 100, 200, 0.50, 60, 100, 0.60, 40, 100, 0.40]
    end
  end
end
