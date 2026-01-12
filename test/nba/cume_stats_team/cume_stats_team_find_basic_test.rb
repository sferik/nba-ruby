require_relative "cume_stats_team_test_helper"

module NBA
  class CumeStatsTeamFindBasicTest < Minitest::Test
    include CumeStatsTeamTestHelper

    cover CumeStatsTeam

    def test_find_returns_hash_with_both_result_sets
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: %w[0022400001 0022400002], season: 2024)

      assert_instance_of Hash, result
      assert_includes result, :game_by_game
      assert_includes result, :total
    end

    def test_find_returns_collection_for_game_by_game
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: %w[0022400001 0022400002], season: 2024)

      assert_instance_of Collection, result[:game_by_game]
    end

    def test_find_returns_cume_stats_team_total_for_total
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      result = CumeStatsTeam.find(team: Team::GSW, game_ids: %w[0022400001 0022400002], season: 2024)

      assert_instance_of CumeStatsTeamTotal, result[:total]
    end

    def test_find_uses_correct_team_id_in_path
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)

      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024)

      assert_requested :get, /TeamID=#{Team::GSW}/o
    end

    def test_find_accepts_team_object
      stub_request(:get, /cumestatsteam/).to_return(body: response.to_json)
      team = Team.new(id: Team::GSW)

      CumeStatsTeam.find(team: team, game_ids: ["0022400001"], season: 2024)

      assert_requested :get, /TeamID=#{Team::GSW}/o
    end

    def test_find_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      CumeStatsTeam.find(team: Team::GSW, game_ids: ["0022400001"], season: 2024, client: mock_client)

      mock_client.verify
    end
  end
end
