require_relative "../test_helper"

module NBA
  class InfographicFanDuelPlayerCountingMappingTest < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_maps_rebound_attributes
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 1, stat.oreb
      assert_equal 5, stat.dreb
      assert_equal 6, stat.reb
    end

    def test_maps_playmaking_attributes
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 8, stat.ast
      assert_equal 3, stat.tov
    end

    def test_maps_defensive_attributes
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 2, stat.stl
      assert_equal 0, stat.blk
      assert_equal 1, stat.blka
    end

    def test_maps_foul_attributes
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 2, stat.pf
      assert_equal 4, stat.pfd
    end

    def test_maps_scoring_attributes
      stub_fan_duel_request

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 30, stat.pts
      assert_equal 15, stat.plus_minus
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
