require_relative "../test_helper"

module NBA
  class BoxScoreAdvancedPlayerStatsEdgeCasesTest < Minitest::Test
    cover BoxScoreAdvanced

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreAdvanced.player_stats(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreAdvanced.player_stats(game: "001").size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreAdvanced.player_stats(game: "001").size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvanced.player_stats(game: "001").size
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "PlayerStats", headers: nil, rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvanced.player_stats(game: "001").size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "PlayerStats", rowSet: [[1, 2, 3]]}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvanced.player_stats(game: "001").size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "PlayerStats", headers: %w[GAME_ID], rowSet: nil}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvanced.player_stats(game: "001").size
    end

    def test_returns_empty_when_rowset_key_missing
      response = {resultSets: [{name: "PlayerStats", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvanced.player_stats(game: "001").size
    end

    def test_player_stats_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]}
      ]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      stats = BoxScoreAdvanced.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_player_stats_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      stats = BoxScoreAdvanced.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    private

    def player_headers
      %w[GAME_ID TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT
        MIN E_OFF_RATING OFF_RATING E_DEF_RATING DEF_RATING E_NET_RATING NET_RATING
        AST_PCT AST_TOV AST_RATIO OREB_PCT DREB_PCT REB_PCT TM_TOV_PCT EFG_PCT TS_PCT
        USG_PCT E_USG_PCT E_PACE PACE PACE_PER40 POSS PIE]
    end

    def player_row
      ["0022400001", Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "",
        "34:22", 115.0, 118.0, 105.0, 108.0, 10.0, 10.0,
        0.35, 2.5, 0.25, 0.05, 0.15, 0.10, 0.12, 0.55, 0.60,
        0.28, 0.30, 98.0, 100.0, 102.0, 50, 0.15]
    end
  end
end
