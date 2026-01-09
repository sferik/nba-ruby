require_relative "../test_helper"

module NBA
  class CumeStatsPlayerNilReturnsTest < Minitest::Test
    cover CumeStatsPlayer

    def test_returns_nil_when_result_sets_empty
      response = {resultSets: []}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_nil result
    end

    def test_returns_nil_when_result_sets_key_missing
      response = {}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_nil result
    end

    def test_returns_nil_when_game_by_game_headers_missing
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, rowSet: [game_row]},
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: [total_row]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_nil result
    end

    def test_returns_nil_when_game_by_game_rows_missing
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: game_headers},
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: [total_row]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_nil result
    end

    def test_returns_nil_when_total_headers_missing
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [game_row]},
        {name: TOTAL_PLAYER_STATS, rowSet: [total_row]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_nil result
    end

    def test_returns_nil_when_total_row_missing
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [game_row]},
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: []}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_nil result
    end

    def test_returns_nil_when_total_rowset_key_missing
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [game_row]},
        {name: TOTAL_PLAYER_STATS, headers: total_headers}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_nil result
    end

    GAME_BY_GAME_STATS = CumeStatsPlayer::GAME_BY_GAME_STATS
    TOTAL_PLAYER_STATS = CumeStatsPlayer::TOTAL_PLAYER_STATS

    private

    def game_headers = TestData.game_headers
    def game_row = TestData.game_row
    def total_headers = TestData.total_headers
    def total_row = TestData.total_row
  end

  class CumeStatsPlayerEdgeCasesTest < Minitest::Test
    cover CumeStatsPlayer

    def test_handles_empty_game_by_game_rowset
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: []},
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: [total_row]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_instance_of Hash, result
      assert_equal 0, result[:game_by_game].size
    end

    def test_handles_nil_values_in_game_data
      stub_response_with_nil_game_row
      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_instance_of Hash, result
      assert_equal 1, result[:game_by_game].size
      assert_nil result[:game_by_game].first.matchup
    end

    def test_handles_nil_values_in_total_data
      stub_response_with_nil_total_row
      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_instance_of Hash, result
      assert_equal 201_939, result[:total].player_id
      assert_nil result[:total].player_name
    end

    def test_uses_first_row_from_total_result_set
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [game_row]},
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: [total_row, second_total_row]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_equal 201_939, result[:total].player_id
      assert_equal "Stephen Curry", result[:total].player_name
    end

    def test_skips_result_set_without_name_key
      unnamed_set = {headers: %w[PLAYER_ID], rowSet: [[999]]}
      response = {resultSets: [
        unnamed_set,
        {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [game_row]},
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: [total_row]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_equal 201_939, result[:total].player_id
    end

    def test_uses_first_matching_result_set
      first_match = {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [game_row]}
      second_match = {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [second_game_row]}
      response = {resultSets: [first_match, second_match,
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: [total_row]}]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_equal "0022400001", result[:game_by_game].first.game_id
    end

    def test_finds_result_set_when_not_first
      other_set = {name: "OtherStats", headers: %w[PLAYER_ID], rowSet: [[999]]}
      response = {resultSets: [
        other_set,
        {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [game_row]},
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: [total_row]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_equal 201_939, result[:total].player_id
    end

    GAME_BY_GAME_STATS = CumeStatsPlayer::GAME_BY_GAME_STATS
    TOTAL_PLAYER_STATS = CumeStatsPlayer::TOTAL_PLAYER_STATS

    private

    def stub_response_with_nil_game_row
      row = ["0022400001", nil, "2024-10-22"] + Array.new(23)
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [row]},
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: [total_row]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def stub_response_with_nil_total_row
      row = [201_939] + Array.new(57)
      response = {resultSets: [
        {name: GAME_BY_GAME_STATS, headers: game_headers, rowSet: [game_row]},
        {name: TOTAL_PLAYER_STATS, headers: total_headers, rowSet: [row]}
      ]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)
    end

    def second_game_row
      ["0022400099", "GSW @ PHX", "2024-10-25", 1_610_612_756, "Phoenix", "Suns",
        30, 0, 8, 18, 0.444, 2, 6, 0.333, 4, 5, 0.800, 1, 4, 5, 6, 2, 1, 2, 0, 22]
    end

    def second_total_row
      [999, "Other Player", "99", "2024-25", 1, 1, 30, 0,
        8, 18, 0.444, 2, 6, 0.333, 4, 5, 0.800, 1, 4, 5, 6, 2, 1, 2, 0, 22,
        30.0, 0.0, 8.0, 18.0, 2.0, 6.0, 4.0, 5.0, 1.0, 4.0,
        5.0, 6.0, 2.0, 1.0, 2.0, 0.0, 22.0,
        30, 8, 18, 2, 6, 4, 5, 1, 4, 5, 6, 2, 1, 2, 0, 22]
    end

    def game_headers = TestData.game_headers
    def game_row = TestData.game_row
    def total_headers = TestData.total_headers
    def total_row = TestData.total_row
  end

  # Shared test data for CumeStatsPlayer tests
  module TestData
    module_function

    def game_headers
      %w[GAME_ID MATCHUP GAME_DATE VS_TEAM_ID VS_TEAM_CITY VS_TEAM_NAME MIN SEC
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST PF STL TOV BLK PTS]
    end

    def game_row
      ["0022400001", "GSW vs. LAL", "2024-10-22", 1_610_612_747, "Los Angeles", "Lakers",
        35, 42, 10, 20, 0.500, 3, 8, 0.375, 7, 8, 0.875, 2, 6, 8, 5, 3, 2, 3, 1, 30]
    end

    def total_headers
      %w[PLAYER_ID PLAYER_NAME JERSEY_NUM SEASON GP GS ACTUAL_MINUTES ACTUAL_SECONDS
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB TOT_REB AST PF STL TOV BLK PTS
        AVG_MIN AVG_SEC AVG_FGM AVG_FGA AVG_FG3M AVG_FG3A AVG_FTM AVG_FTA AVG_OREB AVG_DREB
        AVG_TOT_REB AVG_AST AVG_PF AVG_STL AVG_TOV AVG_BLK AVG_PTS
        MAX_MIN MAX_FGM MAX_FGA MAX_FG3M MAX_FG3A MAX_FTM MAX_FTA MAX_OREB MAX_DREB MAX_REB
        MAX_AST MAX_PF MAX_STL MAX_TOV MAX_BLK MAX_PTS]
    end

    def total_row
      [201_939, "Stephen Curry", "30", "2024-25", 2, 2, 67, 57,
        18, 38, 0.474, 5, 15, 0.333, 12, 14, 0.857, 3, 11, 14, 12, 5, 3, 5, 1, 53,
        33.5, 28.5, 9.0, 19.0, 2.5, 7.5, 6.0, 7.0, 1.5, 5.5,
        7.0, 6.0, 2.5, 1.5, 2.5, 0.5, 26.5,
        35, 10, 20, 3, 8, 7, 8, 2, 6, 8, 7, 3, 2, 3, 1, 30]
    end
  end
end
