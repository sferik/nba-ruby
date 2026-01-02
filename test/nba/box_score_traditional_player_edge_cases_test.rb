require_relative "../test_helper"

module NBA
  class BoxScoreTraditionalPlayerEdgeCasesTest < Minitest::Test
    cover BoxScoreTraditional

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreTraditional.player_stats(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreTraditional.player_stats(game: "001").size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreTraditional.player_stats(game: "001").size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditional.player_stats(game: "001").size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "PlayerStats", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditional.player_stats(game: "001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "PlayerStats", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditional.player_stats(game: "001").size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "PlayerStats", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditional.player_stats(game: "001").size
    end

    def test_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "PlayerStats", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreTraditional.player_stats(game: "001").size
    end

    def test_handles_missing_game_id_header
      headers = %w[TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
      row = [Team::GSW, "GSW", "Golden State", 123, "Test Player", "G", "",
        "34:22", 10, 20, 0.500, 5, 12, 0.417, 6, 6, 1.0, 0, 4, 4, 8, 1, 0, 3, 2, 31, 15]
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      stat = BoxScoreTraditional.player_stats(game: "001").first

      assert_nil stat.game_id
      assert_equal 123, stat.player_id
    end

    def test_handles_missing_player_id
      headers = %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_NAME START_POSITION COMMENT
        MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TO PF PTS PLUS_MINUS]
      row = ["001", Team::GSW, "GSW", "Golden State", "Test Player", "G", "",
        "34:22", 10, 20, 0.500, 5, 12, 0.417, 6, 6, 1.0, 0, 4, 4, 8, 1, 0, 3, 2, 31, 15]
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscoretraditionalv2/).to_return(body: response.to_json)

      stat = BoxScoreTraditional.player_stats(game: "001").first

      assert_nil stat.player_id
      assert_equal "001", stat.game_id
    end
  end
end
