require_relative "../test_helper"

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

  class DraftBoardPlayerAttrTest < Minitest::Test
    cover DraftBoard

    def test_parses_person_id
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal 1_630_162, DraftBoard.all(season: 2023).first.person_id
    end

    def test_parses_player_name
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "Victor Wembanyama", DraftBoard.all(season: 2023).first.player_name
    end

    def test_parses_season
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "2023", DraftBoard.all(season: 2023).first.season
    end

    def test_parses_round_number
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal 1, DraftBoard.all(season: 2023).first.round_number
    end

    def test_parses_round_pick
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal 1, DraftBoard.all(season: 2023).first.round_pick
    end

    def test_parses_overall_pick
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal 1, DraftBoard.all(season: 2023).first.overall_pick
    end

    private

    def response
      headers = %w[PERSON_ID PLAYER_NAME SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK]
      row = [1_630_162, "Victor Wembanyama", "2023", 1, 1, 1]
      {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftBoardTeamAttrTest < Minitest::Test
    cover DraftBoard

    def test_parses_team_id
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal 1_610_612_759, DraftBoard.all(season: 2023).first.team_id
    end

    def test_parses_team_city
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "San Antonio", DraftBoard.all(season: 2023).first.team_city
    end

    def test_parses_team_name
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "Spurs", DraftBoard.all(season: 2023).first.team_name
    end

    def test_parses_team_abbreviation
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "SAS", DraftBoard.all(season: 2023).first.team_abbreviation
    end

    private

    def response
      headers = %w[TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION]
      row = [1_610_612_759, "San Antonio", "Spurs", "SAS"]
      {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftBoardOrgAttrTest < Minitest::Test
    cover DraftBoard

    def test_parses_organization
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "Metropolitans 92", DraftBoard.all(season: 2023).first.organization
    end

    def test_parses_organization_type
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "International", DraftBoard.all(season: 2023).first.organization_type
    end

    private

    def response
      headers = %w[ORGANIZATION ORGANIZATION_TYPE]
      row = ["Metropolitans 92", "International"]
      {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
    end
  end

  class DraftBoardPhysicalAttrTest < Minitest::Test
    cover DraftBoard

    def test_parses_height
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "7-4", DraftBoard.all(season: 2023).first.height
    end

    def test_parses_weight
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "210", DraftBoard.all(season: 2023).first.weight
    end

    def test_parses_position
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "C", DraftBoard.all(season: 2023).first.position
    end

    def test_parses_jersey_number
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "1", DraftBoard.all(season: 2023).first.jersey_number
    end

    def test_parses_birthdate
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_equal "2004-01-04", DraftBoard.all(season: 2023).first.birthdate
    end

    def test_parses_age
      stub_request(:get, /draftboard/).to_return(body: response.to_json)

      assert_in_delta(19.0, DraftBoard.all(season: 2023).first.age)
    end

    private

    def response
      headers = %w[HEIGHT WEIGHT POSITION JERSEY_NUMBER BIRTHDATE AGE]
      row = ["7-4", "210", "C", "1", "2004-01-04", 19.0]
      {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
    end
  end
end
