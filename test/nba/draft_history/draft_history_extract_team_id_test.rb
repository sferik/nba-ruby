require_relative "../../test_helper"

module NBA
  class DraftHistoryExtractTeamIdTest < Minitest::Test
    cover DraftHistory

    def test_by_team_with_team_object_extracts_id
      stub_draft_request_with_gsw
      team = Team.new(id: Team::GSW)

      picks = DraftHistory.by_team(team: team)

      assert_equal 1, picks.size
    end

    private

    def stub_draft_request_with_gsw
      response = {resultSets: [{
        name: "DraftHistory",
        headers: %w[PERSON_ID SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK DRAFT_TYPE TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
          PLAYER_NAME POSITION HEIGHT WEIGHT ORGANIZATION PLAYER_PROFILE_FLAG],
        rowSet: [[1, 2023, 1, 1, 1, "Draft", Team::GSW, "Golden State", "Warriors", "GSW", "Test Player", "G", "6-4", 190, "Duke", "USA"]]
      }]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)
    end
  end
end
