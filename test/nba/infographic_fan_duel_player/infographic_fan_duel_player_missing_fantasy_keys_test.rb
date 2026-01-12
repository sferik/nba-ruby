require_relative "../../test_helper"

module NBA
  class InfographicFanDuelPlayerMissingFantasyKeysTest < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_find_handles_missing_fan_duel_pts
      response = build_response_without("FAN_DUEL_PTS")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.fan_duel_pts
      assert_in_delta 48.5, stat.nba_fantasy_pts, 0.01
    end

    def test_find_handles_missing_nba_fantasy_pts
      response = build_response_without("NBA_FANTASY_PTS")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.nba_fantasy_pts
      assert_in_delta 52.3, stat.fan_duel_pts, 0.01
    end

    def test_find_handles_missing_usg_pct
      response = build_response_without("USG_PCT")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.usg_pct
      assert_in_delta 34.5, stat.min, 0.01
    end

    def test_find_handles_missing_min
      response = build_response_without("MIN")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.min
      assert_in_delta 0.312, stat.usg_pct, 0.001
    end

    private

    def build_response_without(header_to_remove)
      headers = fan_duel_headers.reject { |h| h.eql?(header_to_remove) }
      row = build_row_without(header_to_remove)
      {resultSets: [{name: "FanDuelPlayer", headers: headers, rowSet: [row]}]}
    end

    def build_row_without(header_to_remove)
      index = fan_duel_headers.index(header_to_remove)
      row = fan_duel_row.dup
      row.delete_at(index)
      row
    end

    def fan_duel_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_NAME TEAM_ABBREVIATION JERSEY_NUM
        PLAYER_POSITION LOCATION FAN_DUEL_PTS NBA_FANTASY_PTS USG_PCT MIN
        FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB
        AST TOV STL BLK BLKA PF PFD PTS PLUS_MINUS]
    end

    def fan_duel_row
      [201_939, "Stephen Curry", Team::GSW, "Warriors", "GSW", "30",
        "G", "Home", 52.3, 48.5, 0.312, 34.5, 10, 20, 0.500, 5, 11, 0.455,
        5, 6, 0.833, 1, 5, 6, 8, 3, 2, 0, 1, 2, 4, 30, 15]
    end
  end
end
