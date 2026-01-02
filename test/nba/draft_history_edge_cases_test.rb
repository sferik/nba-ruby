require_relative "../test_helper"

module NBA
  class DraftHistoryEdgeCasesTest < Minitest::Test
    cover DraftHistory

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, DraftHistory.all(client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /drafthistory/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, DraftHistory.all.size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /drafthistory/).to_return(body: {}.to_json)

      assert_equal 0, DraftHistory.all.size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)

      assert_equal 0, DraftHistory.all.size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "DraftHistory", headers: nil, rowSet: [["data"]]}]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)

      assert_equal 0, DraftHistory.all.size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "DraftHistory", rowSet: [["data"]]}]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)

      assert_equal 0, DraftHistory.all.size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "DraftHistory", headers: %w[PERSON_ID], rowSet: nil}]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)

      assert_equal 0, DraftHistory.all.size
    end

    def test_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "DraftHistory", headers: %w[PERSON_ID]}]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)

      assert_equal 0, DraftHistory.all.size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "DraftHistory", headers: draft_headers, rowSet: [draft_row]}
      ]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)

      picks = DraftHistory.all

      assert_equal 1, picks.size
      assert_equal 1_641_705, picks.first.player_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "DraftHistory", headers: draft_headers, rowSet: [draft_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)

      picks = DraftHistory.all

      assert_equal 1, picks.size
      assert_equal 1_641_705, picks.first.player_id
    end

    private

    def draft_headers
      %w[PERSON_ID SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK DRAFT_TYPE TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
        PLAYER_NAME POSITION HEIGHT WEIGHT ORGANIZATION PLAYER_PROFILE_FLAG]
    end

    def draft_row
      [1_641_705, 2023, 1, 1, 1, "Draft", 1_610_612_759, "San Antonio", "Spurs", "SAS", "Victor Wembanyama", "C", "7-4", 210,
        "France", "FRA"]
    end
  end
end
