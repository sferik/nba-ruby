require_relative "../test_helper"

module NBA
  class FranchiseLeadersFindTest < Minitest::Test
    cover FranchiseLeaders

    def test_find_returns_franchise_leader
      stub_franchise_leaders_request

      result = FranchiseLeaders.find(team: Team::GSW)

      assert_instance_of FranchiseLeader, result
    end

    def test_find_uses_team_id_parameter
      stub_franchise_leaders_request

      FranchiseLeaders.find(team: Team::GSW)

      assert_requested :get, /franchiseleaders.*TeamID=#{Team::GSW}/o
    end

    def test_find_accepts_team_object
      stub_franchise_leaders_request
      team = Team.new(id: Team::GSW)

      result = FranchiseLeaders.find(team: team)

      assert_instance_of FranchiseLeader, result
    end

    def test_find_uses_default_nba_league_id
      stub_franchise_leaders_request

      FranchiseLeaders.find(team: Team::GSW)

      assert_requested :get, /franchiseleaders.*LeagueID=00/
    end

    def test_find_accepts_custom_league_id
      stub_franchise_leaders_request

      FranchiseLeaders.find(team: Team::GSW, league: "10")

      assert_requested :get, /franchiseleaders.*LeagueID=10/
    end

    def test_find_accepts_league_object
      stub_franchise_leaders_request
      league = League.new(id: "10", name: "WNBA")

      FranchiseLeaders.find(team: Team::GSW, league: league)

      assert_requested :get, /franchiseleaders.*LeagueID=10/
    end

    def test_find_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, franchise_leaders_response.to_json, [String]

      result = FranchiseLeaders.find(team: Team::GSW, client: mock_client)

      assert_instance_of FranchiseLeader, result
      mock_client.verify
    end

    private

    def stub_franchise_leaders_request
      stub_request(:get, /franchiseleaders/).to_return(body: franchise_leaders_response.to_json)
    end

    def franchise_leaders_response
      {resultSets: [
        {name: "FranchiseLeaders", headers: leader_headers, rowSet: [leader_row]}
      ]}
    end

    def leader_headers
      %w[TEAM_ID PTS_PERSON_ID PTS_PLAYER PTS AST_PERSON_ID AST_PLAYER AST
        REB_PERSON_ID REB_PLAYER REB BLK_PERSON_ID BLK_PLAYER BLK
        STL_PERSON_ID STL_PLAYER STL]
    end

    def leader_row
      [Team::GSW, 201_939, "Stephen Curry", 23_668, 201_939, "Stephen Curry", 5845,
        600_015, "Nate Thurmond", 12_771, 2442, "Manute Bol", 2086,
        959, "Chris Mullin", 1360]
    end
  end
end
