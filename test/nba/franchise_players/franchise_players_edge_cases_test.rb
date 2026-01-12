require_relative "../../test_helper"

module NBA
  class FranchisePlayersEdgeCasesTest < Minitest::Test
    cover FranchisePlayers

    def test_all_returns_empty_collection_when_team_id_is_nil
      assert_equal 0, FranchisePlayers.all(team: nil).size
    end

    def test_all_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, FranchisePlayers.all(team: Team::GSW, client: mock_client).size
      mock_client.verify
    end

    def test_all_returns_empty_collection_when_no_result_sets
      stub_request(:get, /franchiseplayers/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, FranchisePlayers.all(team: Team::GSW).size
    end

    def test_all_returns_empty_collection_when_result_sets_key_missing
      stub_request(:get, /franchiseplayers/).to_return(body: {}.to_json)

      assert_equal 0, FranchisePlayers.all(team: Team::GSW).size
    end

    def test_all_returns_empty_collection_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)

      assert_equal 0, FranchisePlayers.all(team: Team::GSW).size
    end

    def test_all_returns_empty_collection_when_no_headers
      response = {resultSets: [{name: "FranchisePlayers", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)

      assert_equal 0, FranchisePlayers.all(team: Team::GSW).size
    end

    def test_all_returns_empty_collection_when_headers_key_missing
      response = {resultSets: [{name: "FranchisePlayers", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)

      assert_equal 0, FranchisePlayers.all(team: Team::GSW).size
    end

    def test_all_returns_empty_collection_when_no_rows
      response = {resultSets: [{name: "FranchisePlayers", headers: %w[PERSON_ID], rowSet: nil}]}
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)

      assert_equal 0, FranchisePlayers.all(team: Team::GSW).size
    end

    def test_all_returns_empty_collection_when_rowset_key_missing
      response = {resultSets: [{name: "FranchisePlayers", headers: %w[PERSON_ID]}]}
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)

      assert_equal 0, FranchisePlayers.all(team: Team::GSW).size
    end

    def test_all_finds_result_set_when_not_first
      other_set = {name: "OtherData", headers: %w[PERSON_ID PLAYER], rowSet: [[123, "Other Player"]]}
      correct_set = {name: "FranchisePlayers", headers: %w[PERSON_ID PLAYER], rowSet: [[201_939, "Stephen Curry"]]}
      response = {resultSets: [other_set, correct_set]}
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)

      player = FranchisePlayers.all(team: Team::GSW).first

      assert_equal 201_939, player.person_id
      assert_equal "Stephen Curry", player.player
    end

    def test_all_finds_correct_result_set_by_name
      correct_set = {name: "FranchisePlayers", headers: %w[PERSON_ID PLAYER], rowSet: [[201_939, "Stephen Curry"]]}
      other_set = {name: "OtherData", headers: %w[PERSON_ID PLAYER], rowSet: [[123, "Other Player"]]}
      response = {resultSets: [correct_set, other_set]}
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)

      player = FranchisePlayers.all(team: Team::GSW).first

      assert_equal 201_939, player.person_id
      assert_equal "Stephen Curry", player.player
    end

    def test_all_skips_result_set_without_name_key
      unnamed_set = {headers: %w[OTHER], rowSet: [["wrong"]]}
      players_set = {name: "FranchisePlayers", headers: %w[PERSON_ID PLAYER], rowSet: [[201_939, "Stephen Curry"]]}
      response = {resultSets: [unnamed_set, players_set]}
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)

      player = FranchisePlayers.all(team: Team::GSW).first

      assert_equal 201_939, player.person_id
      assert_equal "Stephen Curry", player.player
    end
  end
end
