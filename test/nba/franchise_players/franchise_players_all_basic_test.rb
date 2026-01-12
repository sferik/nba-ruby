require_relative "franchise_players_all_helper"

module NBA
  class FranchisePlayersAllBasicTest < Minitest::Test
    include FranchisePlayersAllHelper

    cover FranchisePlayers

    def setup
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)
    end

    def test_all_returns_collection
      assert_instance_of Collection, FranchisePlayers.all(team: Team::GSW)
    end

    def test_all_uses_team_id_parameter
      FranchisePlayers.all(team: Team::GSW)

      assert_requested :get, /franchiseplayers.*TeamID=#{Team::GSW}/o
    end

    def test_all_accepts_team_object
      team = Team.new(id: Team::GSW, full_name: "Golden State Warriors")

      FranchisePlayers.all(team: team)

      assert_requested :get, /franchiseplayers.*TeamID=#{Team::GSW}/o
    end

    def test_all_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      result = FranchisePlayers.all(team: Team::GSW, client: mock_client)

      assert_equal 1, result.size
      mock_client.verify
    end
  end
end
