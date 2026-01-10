require_relative "../test_helper"

module NBA
  class InfographicFanDuelPlayerFindTest < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_find_returns_collection
      stub_fan_duel_request

      assert_instance_of Collection, InfographicFanDuelPlayer.find(game: "0022400001")
    end

    def test_find_uses_game_id_parameter
      stub_fan_duel_request

      InfographicFanDuelPlayer.find(game: "0022400001")

      assert_requested :get, /infographicfanduelplayer.*GameID=0022400001/
    end

    def test_find_accepts_game_object
      stub_fan_duel_request
      game = Game.new(id: "0022400001")

      InfographicFanDuelPlayer.find(game: game)

      assert_requested :get, /infographicfanduelplayer.*GameID=0022400001/
    end

    def test_find_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, fan_duel_response.to_json, [String]

      result = InfographicFanDuelPlayer.find(game: "0022400001", client: mock_client)

      assert_instance_of Collection, result
      mock_client.verify
    end

    def test_find_parses_player_stats_successfully
      stub_fan_duel_request

      stats = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_equal 1, stats.size
    end

    def test_find_returns_multiple_players
      stub_request(:get, /infographicfanduelplayer/).to_return(body: multi_player_response.to_json)

      stats = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_equal 2, stats.size
    end

    private

    def stub_fan_duel_request
      stub_request(:get, /infographicfanduelplayer/).to_return(body: fan_duel_response.to_json)
    end

    def fan_duel_response
      {resultSets: [{name: "FanDuelPlayer", headers: fan_duel_headers, rowSet: [fan_duel_row]}]}
    end

    def multi_player_response
      rows = [fan_duel_row, klay_thompson_row]
      {resultSets: [{name: "FanDuelPlayer", headers: fan_duel_headers, rowSet: rows}]}
    end

    def fan_duel_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_NAME TEAM_ABBREVIATION JERSEY_NUM PLAYER_POSITION
        LOCATION FAN_DUEL_PTS NBA_FANTASY_PTS USG_PCT MIN FGM FGA FG_PCT FG3M FG3A FG3_PCT
        FTM FTA FT_PCT OREB DREB REB AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def fan_duel_row
      [201_939, "Stephen Curry", Team::GSW, "Warriors", "GSW", "30", "G", "Home",
        52.3, 48.5, 0.312, 34.5, 10, 20, 0.500, 5, 11, 0.455, 5, 6, 0.833,
        1, 5, 6, 8, 3, 2, 0, 1, 2, 4, 30, 15]
    end

    def klay_thompson_row
      [202_691, "Klay Thompson", Team::GSW, "Warriors", "GSW", "11", "G", "Home",
        42.1, 38.5, 0.245, 32.0, 8, 18, 0.444, 4, 10, 0.400, 2, 2, 1.000,
        0, 4, 4, 3, 1, 1, 0, 0, 1, 2, 22, 10]
    end
  end
end
