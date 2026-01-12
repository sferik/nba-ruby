require_relative "../../test_helper"

module NBA
  class LeagueGameLogPlayerEdgeCasesTest < Minitest::Test
    cover LeagueGameLog

    def test_player_logs_returns_empty_when_response_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueGameLog.player_logs(season: 2024, client: mock_client)

      assert_equal 0, result.size
      mock_client.verify
    end

    def test_returns_empty_when_no_result_sets
      stub_request(:get, /leaguegamelog/).to_return(body: {resultSets: nil}.to_json)

      assert_equal 0, LeagueGameLog.player_logs(season: 2024).size
    end

    def test_returns_empty_when_result_sets_key_missing
      stub_request(:get, /leaguegamelog/).to_return(body: {}.to_json)

      assert_equal 0, LeagueGameLog.player_logs(season: 2024).size
    end

    def test_returns_empty_when_headers_key_missing
      response = {resultSets: [{name: "LeagueGameLog", rowSet: [[1]]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.player_logs(season: 2024).size
    end

    def test_returns_empty_when_row_set_key_missing
      response = {resultSets: [{name: "LeagueGameLog", headers: %w[PLAYER_ID]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.player_logs(season: 2024).size
    end

    def test_returns_empty_when_result_set_not_found
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.player_logs(season: 2024).size
    end

    def test_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: player_log_headers, rowSet: [player_log_row]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.player_logs(season: 2024).size
    end

    def test_skips_result_sets_with_missing_name_key
      response = {resultSets: [
        {headers: [], rowSet: []},
        {name: "LeagueGameLog", headers: player_log_headers, rowSet: [player_log_row]}
      ]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      logs = LeagueGameLog.player_logs(season: 2024)

      assert_equal 1, logs.size
      assert_equal 201_939, logs.first.player_id
    end

    def test_returns_empty_when_no_headers
      response = {resultSets: [{name: "LeagueGameLog", headers: nil, rowSet: [[1]]}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.player_logs(season: 2024).size
    end

    def test_returns_empty_when_no_rows
      response = {resultSets: [{name: "LeagueGameLog", headers: %w[PLAYER_ID], rowSet: nil}]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      assert_equal 0, LeagueGameLog.player_logs(season: 2024).size
    end

    def test_finds_result_set_when_not_first
      response = {resultSets: [
        {name: "Other", headers: [], rowSet: []},
        {name: "LeagueGameLog", headers: player_log_headers, rowSet: [player_log_row]}
      ]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      logs = LeagueGameLog.player_logs(season: 2024)

      assert_equal 1, logs.size
      assert_equal 201_939, logs.first.player_id
    end

    def test_finds_result_set_when_not_last
      response = {resultSets: [
        {name: "LeagueGameLog", headers: player_log_headers, rowSet: [player_log_row]},
        {name: "Other", headers: [], rowSet: []}
      ]}
      stub_request(:get, /leaguegamelog/).to_return(body: response.to_json)

      logs = LeagueGameLog.player_logs(season: 2024)

      assert_equal 1, logs.size
      assert_equal 201_939, logs.first.player_id
    end

    private

    def player_log_headers
      %w[SEASON_ID PLAYER_ID GAME_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT FG3M FG3A
        FG3_PCT FTM FTA FT_PCT OREB DREB REB AST STL BLK TOV PF PTS PLUS_MINUS]
    end

    def player_log_row
      ["22024", 201_939, "0022400001", "2024-10-22", "GSW vs. LAL", "W", 34, 11, 22, 0.500,
        5, 12, 0.417, 6, 6, 1.0, 0, 5, 5, 7, 2, 0, 3, 2, 33, 15]
    end
  end
end
