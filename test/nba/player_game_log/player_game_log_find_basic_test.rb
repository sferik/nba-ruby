require_relative "../../test_helper"

module NBA
  class PlayerGameLogFindBasicTest < Minitest::Test
    cover PlayerGameLog

    def test_find_returns_collection
      stub_game_log_request

      assert_instance_of Collection, PlayerGameLog.find(player: 201_939)
    end

    def test_find_uses_correct_player_id_in_path
      stub_game_log_request

      PlayerGameLog.find(player: 201_939)

      assert_requested :get, /playergamelog.*PlayerID=201939/
    end

    def test_find_accepts_player_object
      stub_game_log_request
      player = Player.new(id: 201_939)

      PlayerGameLog.find(player: player)

      assert_requested :get, /playergamelog.*PlayerID=201939/
    end

    private

    def stub_game_log_request
      stub_request(:get, /playergamelog/).to_return(body: game_log_response.to_json)
    end

    def game_log_response = {resultSets: [{headers: game_log_headers, rowSet: [game_log_row]}]}
    def game_log_headers = %w[SEASON_ID Player_ID Game_ID GAME_DATE MATCHUP WL MIN FGM FGA FG_PCT]
    def game_log_row = ["22024", 201_939, "0022400001", "OCT 22, 2024", "GSW vs. LAL", "W", 36, 10, 20, 0.5]
  end
end
