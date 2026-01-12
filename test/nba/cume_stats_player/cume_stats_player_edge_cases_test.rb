require_relative "../../test_helper"
require_relative "cume_stats_player_test_data_helper"

module NBA
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
end
