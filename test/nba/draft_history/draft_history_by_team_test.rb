require_relative "../../test_helper"

module NBA
  class DraftHistoryByTeamTest < Minitest::Test
    cover DraftHistory

    def test_by_team_returns_collection
      stub_draft_request

      assert_instance_of Collection, DraftHistory.by_team(team: Team::GSW)
    end

    def test_by_team_filters_by_team_id
      stub_draft_request_with_multiple_teams

      picks = DraftHistory.by_team(team: Team::GSW)

      assert_equal 1, picks.size
      assert_equal Team::GSW, picks.first.team_id
    end

    def test_by_team_accepts_team_object
      stub_draft_request
      team = Team.new(id: 1_610_612_759)

      DraftHistory.by_team(team: team)

      assert_requested :get, /drafthistory/
    end

    private

    def stub_draft_request
      stub_request(:get, /drafthistory/).to_return(body: draft_response.to_json)
    end

    def stub_draft_request_with_multiple_teams
      response = {resultSets: [{
        name: "DraftHistory",
        headers: %w[PERSON_ID SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK DRAFT_TYPE TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
          PLAYER_NAME POSITION HEIGHT WEIGHT ORGANIZATION PLAYER_PROFILE_FLAG],
        rowSet: [
          [1, 2023, 1, 1, 1, "Draft", 1_610_612_759, "San Antonio", "Spurs", "SAS", "Victor Wembanyama", "C", "7-4", 210, "France", "FRA"],
          [2, 2023, 1, 5, 5, "Draft", Team::GSW, "Golden State", "Warriors", "GSW", "Test Player", "G", "6-4", 190, "Duke", "USA"]
        ]
      }]}
      stub_request(:get, /drafthistory/).to_return(body: response.to_json)
    end

    def draft_response
      {resultSets: [{
        name: "DraftHistory",
        headers: %w[PERSON_ID SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK DRAFT_TYPE TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
          PLAYER_NAME POSITION HEIGHT WEIGHT ORGANIZATION PLAYER_PROFILE_FLAG],
        rowSet: []
      }]}
    end
  end
end
