require_relative "../../test_helper"

module NBA
  class DraftHistoryOptionalFieldsTest < Minitest::Test
    cover DraftHistory

    def test_handles_missing_position
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("POSITION").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.position
    end

    def test_handles_missing_height
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("HEIGHT").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.height
    end

    def test_handles_missing_weight
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("WEIGHT").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.weight
    end

    def test_handles_missing_country
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("PLAYER_PROFILE_FLAG").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.country
    end

    private

    def all_headers
      %w[PERSON_ID SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK DRAFT_TYPE TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
        PLAYER_NAME POSITION HEIGHT WEIGHT ORGANIZATION PLAYER_PROFILE_FLAG]
    end

    def sample_row
      [1_641_705, 2023, 1, 1, 1, "Draft", 1_610_612_759, "San Antonio", "Spurs", "SAS", "Victor Wembanyama", "C", "7-4", 210, "France",
        "FRA"]
    end

    def response_missing_header(header_to_remove)
      headers = all_headers.reject { |h| h == header_to_remove }
      row_index = all_headers.index(header_to_remove)
      row = sample_row.dup
      row.delete_at(row_index)
      {resultSets: [{name: "DraftHistory", headers: headers, rowSet: [row]}]}
    end
  end
end
