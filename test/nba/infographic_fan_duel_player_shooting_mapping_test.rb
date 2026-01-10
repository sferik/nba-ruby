require_relative "../test_helper"

module NBA
  class InfographicFanDuelPlayerShootingMappingTest < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_maps_field_goal_attributes
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 10, stat.fgm
      assert_equal 20, stat.fga
      assert_in_delta 0.500, stat.fg_pct, 0.001
    end

    def test_maps_three_point_attributes
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 5, stat.fg3m
      assert_equal 11, stat.fg3a
      assert_in_delta 0.455, stat.fg3_pct, 0.001
    end

    def test_maps_free_throw_attributes
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 5, stat.ftm
      assert_equal 6, stat.fta
      assert_in_delta 0.833, stat.ft_pct, 0.001
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
