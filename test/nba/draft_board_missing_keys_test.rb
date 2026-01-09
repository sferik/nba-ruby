require_relative "../test_helper"

module NBA
  class DraftBoardMissingPlayerKeysTest < Minitest::Test
    cover DraftBoard

    HEADERS = %w[PERSON_ID PLAYER_NAME SEASON ROUND_NUMBER ROUND_PICK OVERALL_PICK].freeze
    ROW = [1_630_162, "Victor Wembanyama", "2023", 1, 1, 1].freeze

    def test_handles_missing_person_id_key
      stub_with_headers_except("PERSON_ID")

      assert_nil DraftBoard.all(season: 2023).first.person_id
    end

    def test_handles_missing_player_name_key
      stub_with_headers_except("PLAYER_NAME")

      assert_nil DraftBoard.all(season: 2023).first.player_name
    end

    def test_handles_missing_season_key
      stub_with_headers_except("SEASON")

      assert_nil DraftBoard.all(season: 2023).first.season
    end

    def test_handles_missing_round_number_key
      stub_with_headers_except("ROUND_NUMBER")

      assert_nil DraftBoard.all(season: 2023).first.round_number
    end

    def test_handles_missing_round_pick_key
      stub_with_headers_except("ROUND_PICK")

      assert_nil DraftBoard.all(season: 2023).first.round_pick
    end

    def test_handles_missing_overall_pick_key
      stub_with_headers_except("OVERALL_PICK")

      assert_nil DraftBoard.all(season: 2023).first.overall_pick
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
      stub_request(:get, /draftboard/).to_return(body: response.to_json)
    end
  end

  class DraftBoardMissingTeamKeysTest < Minitest::Test
    cover DraftBoard

    HEADERS = %w[TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION].freeze
    ROW = [1_610_612_759, "San Antonio", "Spurs", "SAS"].freeze

    def test_handles_missing_team_id_key
      stub_with_headers_except("TEAM_ID")

      assert_nil DraftBoard.all(season: 2023).first.team_id
    end

    def test_handles_missing_team_city_key
      stub_with_headers_except("TEAM_CITY")

      assert_nil DraftBoard.all(season: 2023).first.team_city
    end

    def test_handles_missing_team_name_key
      stub_with_headers_except("TEAM_NAME")

      assert_nil DraftBoard.all(season: 2023).first.team_name
    end

    def test_handles_missing_team_abbreviation_key
      stub_with_headers_except("TEAM_ABBREVIATION")

      assert_nil DraftBoard.all(season: 2023).first.team_abbreviation
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
      stub_request(:get, /draftboard/).to_return(body: response.to_json)
    end
  end

  class DraftBoardMissingOrgKeysTest < Minitest::Test
    cover DraftBoard

    HEADERS = %w[ORGANIZATION ORGANIZATION_TYPE].freeze
    ROW = ["Metropolitans 92", "International"].freeze

    def test_handles_missing_organization_key
      stub_with_headers_except("ORGANIZATION")

      assert_nil DraftBoard.all(season: 2023).first.organization
    end

    def test_handles_missing_organization_type_key
      stub_with_headers_except("ORGANIZATION_TYPE")

      assert_nil DraftBoard.all(season: 2023).first.organization_type
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
      stub_request(:get, /draftboard/).to_return(body: response.to_json)
    end
  end

  class DraftBoardMissingPhysicalKeysTest < Minitest::Test
    cover DraftBoard

    HEADERS = %w[HEIGHT WEIGHT POSITION JERSEY_NUMBER BIRTHDATE AGE].freeze
    ROW = ["7-4", "210", "C", "1", "2004-01-04", 19.0].freeze

    def test_handles_missing_height_key
      stub_with_headers_except("HEIGHT")

      assert_nil DraftBoard.all(season: 2023).first.height
    end

    def test_handles_missing_weight_key
      stub_with_headers_except("WEIGHT")

      assert_nil DraftBoard.all(season: 2023).first.weight
    end

    def test_handles_missing_position_key
      stub_with_headers_except("POSITION")

      assert_nil DraftBoard.all(season: 2023).first.position
    end

    def test_handles_missing_jersey_number_key
      stub_with_headers_except("JERSEY_NUMBER")

      assert_nil DraftBoard.all(season: 2023).first.jersey_number
    end

    def test_handles_missing_birthdate_key
      stub_with_headers_except("BIRTHDATE")

      assert_nil DraftBoard.all(season: 2023).first.birthdate
    end

    def test_handles_missing_age_key
      stub_with_headers_except("AGE")

      assert_nil DraftBoard.all(season: 2023).first.age
    end

    private

    def stub_with_headers_except(key)
      headers = HEADERS.reject { |h| h == key }
      row = headers.map { |h| ROW[HEADERS.index(h)] }
      response = {resultSets: [{name: "DraftBoard", headers: headers, rowSet: [row]}]}
      stub_request(:get, /draftboard/).to_return(body: response.to_json)
    end
  end
end
