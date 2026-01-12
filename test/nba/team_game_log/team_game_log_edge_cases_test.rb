require_relative "../../test_helper"

module NBA
  class TeamGameLogEdgeCasesTest < Minitest::Test
    cover TeamGameLog

    def test_find_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, TeamGameLog.find(team: Team::GSW, client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_collection_when_no_result_set
      stub_request(:get, /teamgamelog/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, TeamGameLog.find(team: Team::GSW).size
    end

    def test_find_returns_empty_collection_when_result_sets_key_missing
      stub_request(:get, /teamgamelog/).to_return(body: {}.to_json)

      assert_equal 0, TeamGameLog.find(team: Team::GSW).size
    end

    def test_find_returns_empty_collection_when_result_sets_empty
      stub_request(:get, /teamgamelog/).to_return(body: {resultSets: []}.to_json)

      assert_equal 0, TeamGameLog.find(team: Team::GSW).size
    end

    def test_find_returns_empty_collection_when_no_headers
      stub_request(:get, /teamgamelog/).to_return(body: {resultSets: [{headers: nil, rowSet: [[1, 2, 3]]}]}.to_json)

      assert_equal 0, TeamGameLog.find(team: Team::GSW).size
    end

    def test_find_returns_empty_collection_when_headers_key_missing
      stub_request(:get, /teamgamelog/).to_return(body: {resultSets: [{rowSet: [[1, 2, 3]]}]}.to_json)

      assert_equal 0, TeamGameLog.find(team: Team::GSW).size
    end

    def test_find_returns_empty_collection_when_no_rows
      stub_request(:get, /teamgamelog/).to_return(body: {resultSets: [{headers: %w[Team_ID], rowSet: nil}]}.to_json)

      assert_equal 0, TeamGameLog.find(team: Team::GSW).size
    end

    def test_find_returns_empty_collection_when_rowset_key_missing
      stub_request(:get, /teamgamelog/).to_return(body: {resultSets: [{headers: %w[Team_ID]}]}.to_json)

      assert_equal 0, TeamGameLog.find(team: Team::GSW).size
    end

    def test_find_uses_first_result_set_not_last
      first_set = {headers: %w[Team_ID Game_ID], rowSet: [[Team::GSW, "001"]]}
      last_set = {headers: %w[Team_ID Game_ID], rowSet: [[Team::LAL, "002"]]}
      response = {resultSets: [first_set, last_set]}
      stub_request(:get, /teamgamelog/).to_return(body: response.to_json)

      log = TeamGameLog.find(team: Team::GSW).first

      assert_equal Team::GSW, log.team_id
      assert_equal "001", log.game_id
    end

    def test_find_handles_missing_team_id
      response = {resultSets: [{headers: %w[Game_ID], rowSet: [["001"]]}]}
      stub_request(:get, /teamgamelog/).to_return(body: response.to_json)

      log = TeamGameLog.find(team: Team::GSW).first

      assert_nil log.team_id
      assert_equal "001", log.game_id
    end
  end
end
