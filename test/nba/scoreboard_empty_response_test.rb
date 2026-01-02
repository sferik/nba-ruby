require_relative "../test_helper"

module NBA
  class ScoreboardEmptyResponseTest < Minitest::Test
    cover Scoreboard

    def test_games_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, Scoreboard.games(client: mock_client).size
      mock_client.verify
    end

    def test_games_returns_empty_collection_when_no_game_header
      response = {resultSets: [{name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: []}]}
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    def test_games_returns_empty_collection_when_no_result_sets
      stub_request(:get, /scoreboardv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    def test_games_returns_empty_collection_when_no_line_score
      response = {resultSets: [{name: "GameHeader", headers: %w[GAME_ID], rowSet: [["0022400001"]]}]}
      stub_request(:get, /scoreboardv2/).to_return(body: response.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    def test_games_returns_empty_when_no_header_rows
      stub_request(:get, /scoreboardv2/).to_return(body: no_header_rows_response.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    def test_parse_result_set_requires_both_headers_and_rows
      stub_request(:get, /scoreboardv2/).to_return(body: mixed_nil_response.to_json)

      assert_equal 0, Scoreboard.games.size
    end

    private

    def no_header_rows_response
      {resultSets: [
        {name: "GameHeader", headers: nil, rowSet: [["0022400001", "2024-10-22", Team::GSW, 3, Team::LAL, "Arena"]]},
        {name: "LineScore", headers: %w[GAME_ID TEAM_ID PTS], rowSet: []}
      ]}
    end

    def mixed_nil_response
      {resultSets: [
        {name: "GameHeader", headers: %w[GAME_ID], rowSet: nil},
        {name: "LineScore", headers: nil, rowSet: [["0022400001", Team::GSW, 100]]}
      ]}
    end
  end
end
