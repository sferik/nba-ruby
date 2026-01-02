require_relative "../test_helper"

module NBA
  class DraftHistoryMissingKeyTest < Minitest::Test
    cover DraftHistory

    def test_raises_key_error_when_person_id_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("PERSON_ID").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_season_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("SEASON").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_round_number_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("ROUND_NUMBER").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_round_pick_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("ROUND_PICK").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_overall_pick_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("OVERALL_PICK").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_draft_type_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("DRAFT_TYPE").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_team_id_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("TEAM_ID").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_team_city_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("TEAM_CITY").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_team_name_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("TEAM_NAME").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_team_abbreviation_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("TEAM_ABBREVIATION").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_player_name_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("PLAYER_NAME").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_organization_missing
      stub_request(:get, /drafthistory/).to_return(body: response_missing_header("ORGANIZATION").to_json)

      assert_raises(KeyError) { DraftHistory.all }
    end

    def test_raises_key_error_when_result_set_name_missing
      response = {resultSets: [{headers: all_headers, rowSet: [sample_row]}]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)

      assert_raises(KeyError) { DraftHistory.all }
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
