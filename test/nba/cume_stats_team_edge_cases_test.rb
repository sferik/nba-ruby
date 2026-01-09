require_relative "../test_helper"

module NBA
  class CumeStatsTeamNilReturnsTest < Minitest::Test
    cover CumeStatsTeam

    def test_find_returns_nil_when_team_is_nil
      result = CumeStatsTeam.find(team: nil, game_ids: ["0022400001"], season: 2024)

      assert_nil result
    end

    def test_find_returns_nil_when_game_ids_is_nil
      result = CumeStatsTeam.find(team: Team::GSW, game_ids: nil, season: 2024)

      assert_nil result
    end

    def test_find_returns_nil_when_game_ids_is_empty_array
      result = CumeStatsTeam.find(team: Team::GSW, game_ids: [], season: 2024)

      assert_nil result
    end

    def test_find_returns_nil_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024, client: mock_client)

      assert_nil result
      mock_client.verify
    end

    def test_find_returns_nil_when_response_parses_to_nil
      stub_request(:get, /cumestatsteam/).to_return(body: "null")

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_nil result
    end

    def test_find_returns_nil_when_response_is_invalid_json
      stub_request(:get, /cumestatsteam/).to_return(body: "invalid json")

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_nil result
    end

    def test_find_returns_nil_when_result_sets_missing
      stub_request(:get, /cumestatsteam/).to_return(body: {}.to_json)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_nil result
    end

    def test_find_returns_nil_when_both_result_sets_missing
      response = {resultSets: []}.to_json
      stub_request(:get, /cumestatsteam/).to_return(body: response)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_nil result
    end
  end

  class CumeStatsTeamMissingDataTest < Minitest::Test
    cover CumeStatsTeam

    def test_find_handles_result_set_without_name_key
      response = {resultSets: [
        {headers: ["TEAM_ID"], rowSet: [[Team::GSW]]},
        {name: "GameByGameStats", headers: ["PERSON_ID"], rowSet: [[201_939]]},
        {name: "TotalTeamStats", headers: ["TEAM_ID"], rowSet: [[Team::GSW]]}
      ]}.to_json
      stub_request(:get, /cumestatsteam/).to_return(body: response)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_instance_of Hash, result
      assert_instance_of Collection, result[:game_by_game]
      assert_instance_of CumeStatsTeamTotal, result[:total]
    end

    def test_find_returns_empty_collection_when_game_by_game_headers_missing
      response = {resultSets: [
        {name: "GameByGameStats", rowSet: [[201_939]]},
        {name: "TotalTeamStats", headers: ["TEAM_ID"], rowSet: [[Team::GSW]]}
      ]}.to_json
      stub_request(:get, /cumestatsteam/).to_return(body: response)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_instance_of Collection, result[:game_by_game]
      assert_empty result[:game_by_game]
    end

    def test_find_returns_empty_collection_when_game_by_game_rows_missing
      response = {resultSets: [
        {name: "GameByGameStats", headers: ["PERSON_ID"]},
        {name: "TotalTeamStats", headers: ["TEAM_ID"], rowSet: [[Team::GSW]]}
      ]}.to_json
      stub_request(:get, /cumestatsteam/).to_return(body: response)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_instance_of Collection, result[:game_by_game]
      assert_empty result[:game_by_game]
    end

    def test_find_returns_nil_total_when_total_headers_missing
      response = {resultSets: [
        {name: "GameByGameStats", headers: ["PERSON_ID"], rowSet: [[201_939]]},
        {name: "TotalTeamStats", rowSet: [[Team::GSW]]}
      ]}.to_json
      stub_request(:get, /cumestatsteam/).to_return(body: response)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_nil result[:total]
    end

    def test_find_returns_nil_total_when_total_rows_empty
      response = {resultSets: [
        {name: "GameByGameStats", headers: ["PERSON_ID"], rowSet: [[201_939]]},
        {name: "TotalTeamStats", headers: ["TEAM_ID"], rowSet: []}
      ]}.to_json
      stub_request(:get, /cumestatsteam/).to_return(body: response)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_nil result[:total]
    end

    def test_find_returns_nil_total_when_total_rowset_key_missing
      response = {resultSets: [
        {name: "GameByGameStats", headers: ["PERSON_ID"], rowSet: [[201_939]]},
        {name: "TotalTeamStats", headers: ["TEAM_ID"]}
      ]}.to_json
      stub_request(:get, /cumestatsteam/).to_return(body: response)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_nil result[:total]
    end
  end

  class CumeStatsTeamEdgeCasesTest < Minitest::Test
    cover CumeStatsTeam

    def test_find_returns_hash_when_only_game_by_game_present
      response = {resultSets: [{name: "GameByGameStats", headers: ["PERSON_ID"], rowSet: [[201_939]]}]}.to_json
      stub_request(:get, /cumestatsteam/).to_return(body: response)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_instance_of Hash, result
      assert_instance_of Collection, result[:game_by_game]
      assert_nil result[:total]
    end

    def test_find_returns_hash_when_only_total_present
      response = {resultSets: [{name: "TotalTeamStats", headers: ["TEAM_ID"], rowSet: [[Team::GSW]]}]}.to_json
      stub_request(:get, /cumestatsteam/).to_return(body: response)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_instance_of Hash, result
      assert_nil result[:game_by_game]
      assert_instance_of CumeStatsTeamTotal, result[:total]
    end

    def test_uses_first_row_from_total
      response = {resultSets: [
        {name: "GameByGameStats", headers: ["PERSON_ID"], rowSet: [[201_939]]},
        {name: "TotalTeamStats", headers: %w[TEAM_ID NICKNAME],
         rowSet: [[Team::GSW, "Warriors"], [Team::LAL, "Lakers"]]}
      ]}.to_json
      stub_request(:get, /cumestatsteam/).to_return(body: response)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_equal Team::GSW, result[:total].team_id
      assert_equal "Warriors", result[:total].nickname
    end

    def test_normalize_game_ids_handles_single_game_id
      stub_request(:get, /cumestatsteam/).to_return(body: minimal_response.to_json)

      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_requested :get, /GameIDs=0022400001/
    end

    def test_normalize_game_ids_handles_multiple_game_ids
      stub_request(:get, /cumestatsteam/).to_return(body: minimal_response.to_json)

      CumeStatsTeam.find(team: Team::GSW, game_ids: %w[0022400001 0022400002 0022400003], season: 2024)

      assert_requested :get, /GameIDs=0022400001%7C0022400002%7C0022400003/
    end

    private

    def minimal_response
      {resultSets: [
        {name: "GameByGameStats", headers: ["PERSON_ID"], rowSet: [[201_939]]},
        {name: "TotalTeamStats", headers: ["TEAM_ID"], rowSet: [[Team::GSW]]}
      ]}
    end
  end
end
