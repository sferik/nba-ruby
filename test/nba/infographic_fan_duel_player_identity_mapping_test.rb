require_relative "../test_helper"

module NBA
  class InfographicFanDuelPlayerIdentityMappingTest < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_maps_game_id_from_parameter
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
    end

    def test_maps_player_identity_attributes
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal "30", stat.jersey_num
      assert_equal "G", stat.player_position
    end

    def test_maps_team_attributes
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_abbreviation
    end

    def test_maps_location_attribute
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal "Home", stat.location
    end

    private

    def stub_fan_duel_request
      stub_request(:get, /infographicfanduelplayer/).to_return(body: fan_duel_response.to_json)
    end

    def fan_duel_response
      {resultSets: [{name: "FanDuelPlayer", headers: fan_duel_headers, rowSet: [fan_duel_row]}]}
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
  end
end
