require_relative "../test_helper"

module NBA
  class BoxScoreAdvancedTeamStatsEdgeCasesTest < Minitest::Test
    cover BoxScoreAdvanced

    def test_team_stats_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, BoxScoreAdvanced.team_stats(game: "001", client: mock_client).size
      mock_client.verify
    end

    def test_team_stats_returns_empty_when_no_result_sets
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, BoxScoreAdvanced.team_stats(game: "001").size
    end

    def test_team_stats_returns_empty_when_result_sets_key_missing
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: {}.to_json)

      assert_equal 0, BoxScoreAdvanced.team_stats(game: "001").size
    end

    def test_team_stats_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "TeamStats", rowSet: [[1]]}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvanced.team_stats(game: "001").size
    end

    def test_team_stats_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "TeamStats", headers: %w[GAME_ID]}]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      assert_equal 0, BoxScoreAdvanced.team_stats(game: "001").size
    end

    def test_team_stats_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]}
      ]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      stats = BoxScoreAdvanced.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    def test_team_stats_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "TeamStats", headers: team_headers, rowSet: [team_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /boxscoreadvancedv2/).to_return(body: response.to_json)

      stats = BoxScoreAdvanced.team_stats(game: "0022400001")

      assert_equal 1, stats.size
      assert_equal Team::GSW, stats.first.team_id
    end

    private

    def team_headers
      %w[GAME_ID TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY MIN E_OFF_RATING OFF_RATING
        E_DEF_RATING DEF_RATING E_NET_RATING NET_RATING AST_PCT AST_TOV AST_RATIO
        OREB_PCT DREB_PCT REB_PCT TM_TOV_PCT EFG_PCT TS_PCT E_PACE PACE PACE_PER40 POSS PIE]
    end

    def team_row
      ["0022400001", Team::GSW, "Warriors", "GSW", "Golden State", "240:00",
        115.0, 118.0, 105.0, 108.0, 10.0, 10.0, 0.60, 2.0, 0.30,
        0.25, 0.75, 0.50, 0.12, 0.55, 0.58, 98.0, 100.0, 102.0, 200, 0.55]
    end
  end
end
