require_relative "../test_helper"

module NBA
  class BoxScoreScoringTeamEdgeCasesTest < Minitest::Test
    cover BoxScoreScoring

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreScoring.team_stats(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /boxscorescoringv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreScoring.team_stats(game: "001").size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscorescoringv2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreScoring.team_stats(game: "001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "TeamStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreScoring.team_stats(game: "001").size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "TeamStats", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreScoring.team_stats(game: "001").size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "TeamStats", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreScoring.team_stats(game: "001").size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "TeamStats", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreScoring.team_stats(game: "001").size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      stats = BoxScoreScoring.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      stats = BoxScoreScoring.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_handles_missing_game_id
      headers = team_headers_without("GAME_ID")
      row = team_row_without_first
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      stat = BoxScoreScoring.team_stats(game: "001").first

      assert_nil stat.game_id
      assert_equal Team::GSW, stat.team_id
    end

    def test_handles_missing_team_name
      headers = team_headers_without("TEAM_NAME")
      row = team_row_without_index(2)
      response = {resultSets: [{name: "TeamStats", headers: headers, rowSet: [row]}]}
      stub_request(:get, /boxscorescoringv2/).to_return(body: response.to_json)

      stat = BoxScoreScoring.team_stats(game: "001").first

      assert_nil stat.team_name
      assert_equal Team::GSW, stat.team_id
    end

    private

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN PCT_FGA_2PT PCT_FGA_3PT
        PCT_PTS_2PT PCT_PTS_2PT_MR PCT_PTS_3PT PCT_PTS_FB PCT_PTS_FT PCT_PTS_OFF_TOV PCT_PTS_PAINT
        PCT_AST_2PM PCT_UAST_2PM PCT_AST_3PM PCT_UAST_3PM PCT_AST_FGM PCT_UAST_FGM]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        0.45, 0.55, 0.25, 0.1, 0.45, 0.12, 0.15, 0.08, 0.30, 0.6, 0.4, 0.7, 0.3, 0.65, 0.35]
    end

    def team_headers_without(key)
      team_headers.reject { |h| h == key }
    end

    def team_row_without_first
      team_row[1..]
    end

    def team_row_without_index(idx)
      team_row[0...idx] + team_row[(idx + 1)..]
    end
  end
end
