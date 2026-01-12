require_relative "../../test_helper"

module NBA
  class BoxScoreScoringPlayerEdgeCasesTest < Minitest::Test
    cover BoxScoreScoring

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreScoring.player_stats(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /boxscorescoringv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreScoring.player_stats(game: "001").size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscorescoringv2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreScoring.player_stats(game: "001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "PlayerStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreScoring.player_stats(game: "001").size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "PlayerStats", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreScoring.player_stats(game: "001").size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "PlayerStats", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreScoring.player_stats(game: "001").size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "PlayerStats", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreScoring.player_stats(game: "001").size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]}
      ]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      stats = BoxScoreScoring.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      stats = BoxScoreScoring.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_handles_missing_game_id
      headers = player_headers_without("GAME_ID")
      row = player_row_without_first
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      stat = BoxScoreScoring.player_stats(game: "001").first

      assert_nil stat.game_id
      assert_equal 201_939, stat.player_id
    end

    def test_handles_missing_player_name
      headers = player_headers_without("PLAYER_NAME")
      row = player_row_without_index(5)
      response = {resultSets: [{name: "PlayerStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      stat = BoxScoreScoring.player_stats(game: "001").first

      assert_nil stat.player_name
      assert_equal 201_939, stat.player_id
    end

    private

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN PCT_FGA_2PT PCT_FGA_3PT PCT_PTS_2PT PCT_PTS_2PT_MR PCT_PTS_3PT PCT_PTS_FB PCT_PTS_FT
        PCT_PTS_OFF_TOV PCT_PTS_PAINT PCT_AST_2PM PCT_UAST_2PM PCT_AST_3PM PCT_UAST_3PM PCT_AST_FGM PCT_UAST_FGM]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 0.4, 0.6, 0.2, 0.1, 0.5, 0.15, 0.1, 0.05, 0.25, 0.3, 0.7, 0.5, 0.5, 0.4, 0.6]
    end

    def player_headers_without(key)
      player_headers.reject { |h| h == key }
    end

    def player_row_without_first
      player_row[1..]
    end

    def player_row_without_index(idx)
      player_row[0...idx] + player_row[(idx + 1)..]
    end
  end
end
