require_relative "../test_helper"

module NBA
  class DraftHistoryByTeamClientPassThroughTest < Minitest::Test
    cover DraftHistory

    def test_by_team_passes_client_to_all
      mock_client = Minitest::Mock.new
      mock_client.expect :get, draft_response.to_json, [String]

      DraftHistory.by_team(team: Team::GSW, client: mock_client)

      mock_client.verify
    end

    private

    def draft_response
      {resultSets: [{
        name: "DraftHistory",
        headers: %w[PERSON_ID SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK DRAFT_TYPE TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
          PLAYER_NAME POSITION HEIGHT WEIGHT ORGANIZATION PLAYER_PROFILE_FLAG],
        rowSet: [[1, 2023, 1, 1, 1, "Draft", Team::GSW, "Golden State", "Warriors", "GSW", "Test Player", "G", "6-4", 190, "Duke", "USA"]]
      }]}
    end
  end
end
