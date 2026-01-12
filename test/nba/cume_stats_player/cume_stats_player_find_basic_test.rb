require_relative "../../test_helper"
require_relative "cume_stats_player_find_test_helper"

module NBA
  class CumeStatsPlayerFindBasicTest < Minitest::Test
    cover CumeStatsPlayer

    def test_find_returns_hash_with_game_by_game_and_total
      stub_cume_stats_player_request

      result = CumeStatsPlayer.find(player: 201_939, game_ids: %w[0022400001 0022400002],
        season: "2024-25")

      assert_instance_of Hash, result
      assert_instance_of Collection, result[:game_by_game]
      assert_instance_of CumeStatsPlayerTotal, result[:total]
    end

    def test_find_uses_player_id_parameter
      stub_cume_stats_player_request

      CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_requested :get, /cumestatsplayer.*PlayerID=201939/
    end

    def test_find_accepts_player_object
      stub_cume_stats_player_request
      player = Player.new(id: 201_939)

      result = CumeStatsPlayer.find(player: player, game_ids: ["0022400001"], season: "2024-25")

      assert_instance_of Hash, result
    end

    def test_find_accepts_game_ids_as_array
      stub_cume_stats_player_request

      CumeStatsPlayer.find(player: 201_939, game_ids: %w[0022400001 0022400002], season: "2024-25")

      assert_requested :get, /cumestatsplayer.*GameIDs=0022400001%7C0022400002/
    end

    def test_find_accepts_game_ids_as_pipe_separated_string
      stub_cume_stats_player_request

      CumeStatsPlayer.find(player: 201_939, game_ids: "0022400001|0022400002", season: "2024-25")

      assert_requested :get, /cumestatsplayer.*GameIDs=0022400001%7C0022400002/
    end

    def test_find_uses_season_parameter
      stub_cume_stats_player_request

      CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25")

      assert_requested :get, /cumestatsplayer.*Season=2024-25/
    end

    def test_find_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, CumeStatsPlayerFindTestHelper.cume_stats_player_response.to_json, [String]

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25",
        client: mock_client)

      assert_instance_of Hash, result
      mock_client.verify
    end

    def test_find_returns_nil_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = CumeStatsPlayer.find(player: 201_939, game_ids: ["0022400001"], season: "2024-25",
        client: mock_client)

      assert_nil result
      mock_client.verify
    end

    private

    def stub_cume_stats_player_request
      stub_request(:get, /cumestatsplayer/).to_return(body: CumeStatsPlayerFindTestHelper.cume_stats_player_response.to_json)
    end
  end
end
