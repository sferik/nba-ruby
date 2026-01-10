require_relative "../test_helper"
require_relative "cume_stats_player_test_data_helper"

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
end
