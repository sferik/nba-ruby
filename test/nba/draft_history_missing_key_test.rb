require_relative "../test_helper"

module NBA
  class DraftHistoryMissingKeyTest < Minitest::Test
    cover DraftHistory

    def test_handles_missing_person_id
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("PERSON_ID").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.player_id
      assert_equal "Victor Wembanyama", pick.player_name
    end

    def test_handles_missing_season
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("SEASON").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.season
      assert_equal 1_641_705, pick.player_id
    end

    def test_handles_missing_round_number
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("ROUND_NUMBER").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.round_number
      assert_equal 1_641_705, pick.player_id
    end

    def test_handles_missing_round_pick
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("ROUND_PICK").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.round_pick
      assert_equal 1_641_705, pick.player_id
    end

    def test_handles_missing_overall_pick
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("OVERALL_PICK").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.overall_pick
      assert_equal 1_641_705, pick.player_id
    end

    def test_handles_missing_draft_type
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("DRAFT_TYPE").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.draft_type
      assert_equal 1_641_705, pick.player_id
    end

    def test_handles_missing_team_id
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("TEAM_ID").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.team_id
      assert_equal 1_641_705, pick.player_id
    end

    def test_handles_missing_team_city
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("TEAM_CITY").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.team_city
      assert_equal 1_641_705, pick.player_id
    end

    def test_handles_missing_team_name
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("TEAM_NAME").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.team_name
      assert_equal 1_641_705, pick.player_id
    end

    def test_handles_missing_team_abbreviation
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("TEAM_ABBREVIATION").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.team_abbreviation
      assert_equal 1_641_705, pick.player_id
    end

    def test_handles_missing_player_name
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("PLAYER_NAME").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.player_name
      assert_equal 1_641_705, pick.player_id
    end

    def test_handles_missing_organization
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("ORGANIZATION").to_json)

      pick = DraftHistory.all.first

      assert_nil pick.college
      assert_equal 1_641_705, pick.player_id
    end

    def test_returns_empty_when_result_set_name_missing
      response = {resultSets: [{headers: all_headers, rowSet: [sample_row]}]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)

      assert_equal 0, DraftHistory.all.size
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
