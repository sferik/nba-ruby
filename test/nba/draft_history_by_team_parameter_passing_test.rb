require_relative "../test_helper"

module NBA
  class DraftHistoryByTeamParameterPassingTest < Minitest::Test
    cover DraftHistory

    def test_by_team_passes_season_parameter
      stub_draft_request

      DraftHistory.by_team(team: Team::GSW, season: 2023)

      assert_requested :get, /Season=2023/
    end

    def test_by_team_passes_league_id_parameter
      stub_draft_request

      DraftHistory.by_team(team: Team::GSW, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_by_team_works_with_integer_team_id
      stub_draft_request_with_gsw

      picks = DraftHistory.by_team(team: Team::GSW)

      assert_equal 1, picks.size
    end

    def test_by_team_uses_default_league_id_when_not_specified
      stub_draft_request

      DraftHistory.by_team(team: Team::GSW)

      assert_requested :get, /LeagueID=00/
    end

    def test_by_team_omits_season_from_url_when_not_specified
      stub_draft_request

      DraftHistory.by_team(team: Team::GSW)

      assert_requested :get, ->(uri) { !uri.to_s.include?("Season=") }
    end

    private

    def stub_draft_request
      stub_request(:get, /drafthistory/).to_return(body: draft_response.to_json)
    end

    def stub_draft_request_with_gsw
      response = {resultSets: [{
        name: "DraftHistory",
        headers: %w[PERSON_ID SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK DRAFT_TYPE TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
          PLAYER_NAME POSITION HEIGHT WEIGHT ORGANIZATION PLAYER_PROFILE_FLAG],
        rowSet: [[1, 2023, 1, 1, 1, "Draft", Team::GSW, "Golden State", "Warriors", "GSW", "Test Player", "G", "6-4", 190, "Duke", "USA"]]
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
