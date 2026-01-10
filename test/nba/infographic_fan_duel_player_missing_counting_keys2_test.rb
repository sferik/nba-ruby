require_relative "../test_helper"

module NBA
  class InfographicFanDuelPlayerMissingCountingKeys2Test < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_find_handles_missing_blk
      response = build_response_without("BLK")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.blk
      assert_equal 2, stat.stl
    end

    def test_find_handles_missing_blka
      response = build_response_without("BLKA")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.blka
      assert_equal 0, stat.blk
    end

    def test_find_handles_missing_pf
      response = build_response_without("PF")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.pf
      assert_equal 1, stat.blka
    end

    def test_find_handles_missing_pfd
      response = build_response_without("PFD")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.pfd
      assert_equal 2, stat.pf
    end

    def test_find_handles_missing_pts
      response = build_response_without("PTS")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.pts
      assert_equal 4, stat.pfd
    end

    def test_find_handles_missing_plus_minus
      response = build_response_without("PLUS_MINUS")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.plus_minus
      assert_equal 30, stat.pts
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
