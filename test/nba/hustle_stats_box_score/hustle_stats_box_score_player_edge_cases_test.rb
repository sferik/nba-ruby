require_relative "../../test_helper"

module NBA
  class HustleStatsBoxScorePlayerEdgeCasesTest < Minitest::Test
    cover HustleStatsBoxScore

    def test_player_stats_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = HustleStatsBoxScore.player_stats(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_player_stats_returns_empty_when_no_result_sets
      stub_request(:get, /hustlestatsboxscore/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, HustleStatsBoxScore.player_stats(game: "0022400001").size
    end

    def test_player_stats_returns_empty_when_headers_missing
      response = {resultSets: [{name: "PlayerStats", rowSet: [[1]]}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      assert_equal 0, HustleStatsBoxScore.player_stats(game: "0022400001").size
    end

    def test_player_stats_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]}
      ]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      stats = HustleStatsBoxScore.player_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_player_stats_finds_correct_result_set_when_not_last
      response = {resultSets: [
        {name: "PlayerStats", headers: player_headers, rowSet: [player_row]},
        {name: "Other", headers: %w[WRONG], rowSet: [["wrong_data"]]}
      ]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      stats = HustleStatsBoxScore.player_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal "Stephen Curry", stats.first.player_name
    end

    def test_player_stats_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "PlayerStats", headers: player_headers}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      assert_equal 0, HustleStatsBoxScore.player_stats(game: "0022400001").size
    end

    def test_player_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /hustlestatsboxscore/).to_return(body: {}.to_json)

      assert_equal 0, HustleStatsBoxScore.player_stats(game: "0022400001").size
    end

    def test_player_stats_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "OtherResultSet", headers: player_headers, rowSet: [player_row]}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      assert_equal 0, HustleStatsBoxScore.player_stats(game: "0022400001").size
    end

    private

    def player_headers
      %w[TEAM_ID TEAM_ABBREVIATION TEAM_CITY PLAYER_ID PLAYER_NAME START_POSITION COMMENT MINUTES PTS
        CONTESTED_SHOTS CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS
        SCREEN_AST_PTS LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
        BOX_OUTS OFF_BOXOUTS DEF_BOXOUTS]
    end

    def player_row
      [Team::GSW, "GSW", "Golden State", 201_939, "Stephen Curry", "G", "", "32:45", 28,
        8, 5, 3, 4, 1, 3, 6, 2, 1, 1, 3, 1, 2]
    end
  end
end
