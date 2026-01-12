require_relative "cume_stats_player_games_all_helper"

module NBA
  class CumeStatsPlayerGamesAllBasicTest < Minitest::Test
    include CumeStatsPlayerGamesAllHelper

    cover CumeStatsPlayerGames

    def setup
      stub_request(:get, /cumestatsplayergames/).to_return(body: response.to_json)
    end

    def test_all_returns_collection
      assert_instance_of Collection, CumeStatsPlayerGames.all(player: 201_939, season: 2024)
    end

    def test_all_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = CumeStatsPlayerGames.all(player: 201_939, season: 2024, client: mock_client)

      assert_instance_of Collection, result
      assert_predicate result, :empty?
      mock_client.verify
    end

    def test_all_sends_correct_endpoint
      CumeStatsPlayerGames.all(player: 201_939, season: 2024)

      assert_requested :get, /cumestatsplayergames/
    end

    def test_all_uses_player_id_parameter
      CumeStatsPlayerGames.all(player: 201_939, season: 2024)

      assert_requested :get, /cumestatsplayergames.*PlayerID=201939/
    end

    def test_all_accepts_player_object
      player = Player.new(id: 201_939)

      result = CumeStatsPlayerGames.all(player: player, season: 2024)

      assert_instance_of Collection, result
    end

    def test_all_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      result = CumeStatsPlayerGames.all(player: 201_939, season: 2024, client: mock_client)

      assert_instance_of Collection, result
      mock_client.verify
    end

    def test_all_parses_game_id
      entry = CumeStatsPlayerGames.all(player: 201_939, season: 2024).first

      assert_equal "0022400001", entry.game_id
    end

    def test_all_parses_matchup
      entry = CumeStatsPlayerGames.all(player: 201_939, season: 2024).first

      assert_equal "GSW vs. LAL", entry.matchup
    end
  end
end
