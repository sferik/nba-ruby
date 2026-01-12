require_relative "../../test_helper"

module NBA
  class DraftBoardAllTest < Minitest::Test
    cover DraftBoard

    HEADERS = %w[
      PERSON_ID PLAYER_NAME SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK
      TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
      ORGANIZATION ORGANIZATION_TYPE
      HEIGHT WEIGHT POSITION JERSEY_NUMBER BIRTHDATE AGE
    ].freeze

    ROW = [
      1_630_162, "Victor Wembanyama", "2023", 1, 1, 1,
      1_610_612_759, "San Antonio", "Spurs", "SAS",
      "Metropolitans 92", "International",
      "7-4", "210", "C", "1", "2004-01-04", 19.0
    ].freeze

    def test_all_returns_collection
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      result = DraftBoard.all(season: 2023)

      assert_instance_of Collection, result
    end

    def test_all_uses_correct_season_in_path
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      DraftBoard.all(season: 2023)

      assert_requested :get, /SeasonYear=2023/
    end

    def test_all_uses_correct_league_in_path
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      DraftBoard.all(season: 2023, league: "10")

      assert_requested :get, /LeagueID=10/
    end

    def test_all_uses_default_league_when_not_specified
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      DraftBoard.all(season: 2023)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_parses_picks_successfully
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      picks = DraftBoard.all(season: 2023)

      assert_equal 1, picks.size
      assert_equal 1_630_162, picks.first.person_id
      assert_equal "Victor Wembanyama", picks.first.player_name
    end

    def test_all_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      DraftBoard.all(season: 2023, client: mock_client)

      mock_client.verify
    end

    def test_all_accepts_league_object
      stub_request(:get, /draftboard/).to_return(body: response.to_json)
      league = League.new(id: "10")

      DraftBoard.all(season: 2023, league: league)

      assert_requested :get, /LeagueID=10/
    end

    private

    def response
      {resultSets: [{name: "DraftBoard", headers: HEADERS, rowSet: [ROW]}]}
    end
  end
end
