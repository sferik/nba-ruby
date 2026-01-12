require_relative "../../test_helper"

module NBA
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
end
