require_relative "../test_helper"

module NBA
  class BoxScoreUsagePlayerEdgeCasesTest < Minitest::Test
    cover BoxScoreUsage

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreUsage.player_stats(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /boxscoreusagev2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreUsage.player_stats(game: "001").size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoreusagev2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreUsage.player_stats(game: "001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "PlayerStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreUsage.player_stats(game: "001").size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "PlayerStats", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreUsage.player_stats(game: "001").size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreUsage.player_stats(game: "001").size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "PlayerStats", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreUsage.player_stats(game: "001").size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "PlayerStats", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreUsage.player_stats(game: "001").size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]}
      ]}
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)

      stats = BoxScoreUsage.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /boxscoreusagev2/).to_return(body: response.to_json)

      stats = BoxScoreUsage.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    private

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT MIN
        USG_PCT PCT_FGM PCT_FGA PCT_FG3M PCT_FG3A PCT_FTM PCT_FTA PCT_OREB PCT_DREB PCT_REB
        PCT_AST PCT_TOV PCT_STL PCT_BLK PCT_BLKA PCT_PF PCT_PFD PCT_PTS]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 0.285, 0.24, 0.27, 0.35, 0.38, 0.28, 0.30, 0.15, 0.22, 0.19,
        0.32, 0.18, 0.25, 0.20, 0.12, 0.16, 0.21, 0.26]
    end
  end
end
