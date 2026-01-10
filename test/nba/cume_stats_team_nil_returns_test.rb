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
end
