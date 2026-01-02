require_relative "../test_helper"

module NBA
  class DraftHistoryAllTest < Minitest::Test
    cover DraftHistory

    def test_all_returns_collection
      stub_draft_request

      assert_instance_of Collection, DraftHistory.all
    end

    def test_all_uses_correct_league_id_in_path
      stub_draft_request

      DraftHistory.all

      assert_requested :get, /drafthistory.*LeagueID=00/
    end

    def test_all_with_season_uses_correct_season_in_path
      stub_draft_request

      DraftHistory.all(season: 2023)

      assert_requested :get, /drafthistory.*Season=2023/
    end

    def test_all_parses_draft_picks_successfully
      stub_draft_request

      picks = DraftHistory.all

      assert_equal 1, picks.size
      assert_equal "Victor Wembanyama", picks.first.player_name
    end

    def test_all_accepts_league_object
      stub_draft_request
      league = League.new(id: "10", name: "WNBA")

      DraftHistory.all(league: league)

      assert_requested :get, /drafthistory.*LeagueID=10/
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
