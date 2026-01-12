require_relative "../../test_helper"

module NBA
  class BoxScoreTraditionalTeamEdgeCasesTest < Minitest::Test
    cover BoxScoreTraditional

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreTraditional.team_stats(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreTraditional.team_stats(game: "001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "TeamStats", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditional.team_stats(game: "001").size
    end

    def test_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "TeamStats", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditional.team_stats(game: "001").size
    end

    def test_handles_missing_game_id_header
      headers = %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
      row = [456, "Warriors", "GSW", "Golden State", "240:00", 42, 88, 0.477, 15, 40,
        0.375, 20, 25, 0.8, 10, 35, 45, 28, 8, 5, 12, 18, 119, 12]
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      stat = BoxScoreTraditional.team_stats(game: "001").first

      assert_nil stat.game_id
      assert_equal 456, stat.team_id
      assert_equal "Warriors", stat.team_name
    end

    def test_handles_missing_team_name_header
      headers = %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
      row = ["001", 456, "GSW", "Golden State", "240:00", 42, 88, 0.477, 15, 40,
        0.375, 20, 25, 0.8, 10, 35, 45, 28, 8, 5, 12, 18, 119, 12]
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      stat = BoxScoreTraditional.team_stats(game: "001").first

      assert_equal "001", stat.game_id
      assert_nil stat.team_name
    end

    def test_handles_missing_team_id_header
      headers = %w[GAME_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
      row = ["001", "Warriors", "GSW", "Golden State", "240:00", 42, 88, 0.477, 15, 40,
        0.375, 20, 25, 0.8, 10, 35, 45, 28, 8, 5, 12, 18, 119, 12]
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      stat = BoxScoreTraditional.team_stats(game: "001").first

      assert_equal "001", stat.game_id
      assert_nil stat.team_id
      assert_equal "Warriors", stat.team_name
    end
  end
end
