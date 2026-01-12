require_relative "../../test_helper"

module NBA
  class InfographicFanDuelPlayerFantasyMappingTest < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_maps_fan_duel_pts
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_in_delta 52.3, stat.fan_duel_pts, 0.01
    end

    def test_maps_nba_fantasy_pts
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_in_delta 48.5, stat.nba_fantasy_pts, 0.01
    end

    def test_maps_usg_pct
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_in_delta 0.312, stat.usg_pct, 0.001
    end

    def test_maps_min
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_in_delta 34.5, stat.min, 0.01
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
