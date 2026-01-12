require_relative "../../test_helper"

module NBA
  class LeagueGameFinderEdgeCasesTest < Minitest::Test
    cover LeagueGameFinder

    def test_by_team_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, LeagueGameFinder.by_team(team: Team::GSW, client: mock_client).size
      mock_client.verify
    end

    def test_by_player_returns_empty_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, LeagueGameFinder.by_player(player: 201_939, client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /leaguegamefinder/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueGameFinder.by_team(team: Team::GSW).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "OtherResultSet", headers: [], rowSet: []}]}
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameFinder.by_team(team: Team::GSW).size
    end

    def test_returns_empty_when_headers_nil
      response = {resultSets: [{name: "TeamGameFinderResults", headers: nil, rowSet: [["data"]]}]}
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameFinder.by_team(team: Team::GSW).size
    end

    def test_returns_empty_when_rows_nil
      response = {resultSets: [{name: "TeamGameFinderResults", headers: ["GAME_ID"], rowSet: nil}]}
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameFinder.by_team(team: Team::GSW).size
    end

    def test_selects_correct_result_set_when_multiple_exist
      response = {
        resultSets: [
          {name: "OtherResults", headers: ["ID"], rowSet: [["wrong"]]},
          {name: "TeamGameFinderResults", headers: ["GAME_ID"], rowSet: [["correct"]]}
        ]
      }
      stub_request(:get, /leaguegamefinder/).to_return(body: response.to_json)
      games = LeagueGameFinder.by_team(team: Team::GSW)

      assert_equal 1, games.size
      assert_equal "correct", games.first.game_id
    end
  end
end
