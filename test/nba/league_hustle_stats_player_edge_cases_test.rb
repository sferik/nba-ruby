require_relative "../test_helper"
require_relative "league_hustle_stats_player_test_helper"

module NBA
  class LeagueHustleStatsPlayerEdgeCasesTest < Minitest::Test
    include LeagueHustleStatsPlayerTestHelper

    cover LeagueHustleStatsPlayer

    def test_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueHustleStatsPlayer.all(season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueHustleStatsPlayer.all(season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: {}.to_json)

      assert_equal 0, LeagueHustleStatsPlayer.all(season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "HustleStatsPlayer", rowSet: [[1]]}]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStatsPlayer.all(season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "HustleStatsPlayer", headers: %w[PLAYER_ID]}]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStatsPlayer.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStatsPlayer.all(season: 2024).size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: stat_headers, rowSet: [stat_row]}]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStatsPlayer.all(season: 2024).size
    end

    def test_skips_result_sets_with_missing_name_key
      response = {resultSets: [
        {headers: [], rowSet: []},
        {name: "HustleStatsPlayer", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "HustleStatsPlayer", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStatsPlayer.all(season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "HustleStatsPlayer", headers: %w[PLAYER_ID], rowSet: nil}]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      assert_equal 0, LeagueHustleStatsPlayer.all(season: 2024).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "HustleStatsPlayer", headers: stat_headers, rowSet: [stat_row]}
      ]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal 201_939, stats.first.player_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "HustleStatsPlayer", headers: stat_headers, rowSet: [stat_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)

      stats = LeagueHustleStatsPlayer.all(season: 2024)

      assert_equal 1, stats.size
      assert_equal "Stephen Curry", stats.first.player_name
    end
  end
end
