require_relative "../test_helper"
require_relative "cume_stats_player_find_test_helper"

module NBA
  class CumeStatsPlayerFindResultSetTest < Minitest::Test
    cover CumeStatsPlayer

    GAME_BY_GAME_STATS = CumeStatsPlayer::GAME_BY_GAME_STATS
    TOTAL_PLAYER_STATS = CumeStatsPlayer::TOTAL_PLAYER_STATS

    def test_find_returns_nil_when_game_by_game_result_set_missing
      response = {resultSets: [{name: TOTAL_PLAYER_STATS, headers: CumeStatsPlayerFindTestHelper.total_headers,
                                rowSet: [CumeStatsPlayerFindTestHelper.total_row]}]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_nil result
    end

    def test_find_returns_nil_when_total_result_set_missing
      response = {resultSets: [{name: GAME_BY_GAME_STATS, headers: CumeStatsPlayerFindTestHelper.game_headers,
                                rowSet: [CumeStatsPlayerFindTestHelper.game_row]}]}
      stub_request(:get, /cumestatsplayer/).to_return(body: response.to_json)

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_nil result
    end
  end
end
