require_relative "../../test_helper"

module NBA
  class DraftHistoryPlayerPhysicalAttributeMappingTest < Minitest::Test
    cover DraftHistory

    def test_maps_player_physical_attributes
      stub_draft_request

      pick = DraftHistory.all.first

      assert_equal "7-4", pick.height
      assert_equal 210, pick.weight
    end

    private

    def stub_draft_request
      stub_request(:get, /drafthistory/).to_return(body: draft_response.to_json)
    end

    def draft_response
      {resultSets: [{
        name: "DraftHistory",
        headers: %w[PERSON_ID SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK DRAFT_TYPE TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
          PLAYER_NAME POSITION HEIGHT WEIGHT ORGANIZATION PLAYER_PROFILE_FLAG],
        rowSet: [[1_641_705, 2023, 1, 1, 1, "Draft", 1_610_612_759, "San Antonio", "Spurs", "SAS", "Victor Wembanyama", "C", "7-4", 210,
          "France", "FRA"]]
      }]}
    end
  end
end
