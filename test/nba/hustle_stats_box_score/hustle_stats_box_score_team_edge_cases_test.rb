require_relative "../../test_helper"

module NBA
  class HustleStatsBoxScoreTeamEdgeCasesTest < Minitest::Test
    cover HustleStatsBoxScore

    def test_team_stats_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = HustleStatsBoxScore.team_stats(game: "0022400001", client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_team_stats_returns_empty_when_no_result_sets
      stub_request(:get, /hustlestatsboxscore/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, HustleStatsBoxScore.team_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_headers_missing
      response = {resultSets: [{name: "TeamStats", rowSet: [[1]]}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      assert_equal 0, HustleStatsBoxScore.team_stats(game: "0022400001").size
    end

    def test_team_stats_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      stats = HustleStatsBoxScore.team_stats(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_team_stats_returns_empty_when_row_set_missing
      response = {resultSets: [{name: "TeamStats", headers: team_headers}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      assert_equal 0, HustleStatsBoxScore.team_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /hustlestatsboxscore/).to_return(body: {}.to_json)

      assert_equal 0, HustleStatsBoxScore.team_stats(game: "0022400001").size
    end

    def test_team_stats_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "OtherResultSet", headers: team_headers, rowSet: [team_row]}]}
      stub_request(:get, /hustlestatsboxscore/).to_return(body: response.to_json)

      assert_equal 0, HustleStatsBoxScore.team_stats(game: "0022400001").size
    end

    private

    def team_headers
      %w[TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MINUTES PTS CONTESTED_SHOTS CONTESTED_SHOTS_2PT
        CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS SCREEN_AST_PTS
        LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
        BOX_OUTS OFF_BOXOUTS DEF_BOXOUTS]
    end

    def team_row
      [Team::GSW, "Warriors", "GSW", "Golden State", "240:00", 118,
        45, 30, 15, 12, 2, 18, 36, 8, 3, 5, 25, 8, 17]
    end
  end
end
