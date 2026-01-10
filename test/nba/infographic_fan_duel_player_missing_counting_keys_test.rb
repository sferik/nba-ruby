require_relative "../test_helper"

module NBA
  class InfographicFanDuelPlayerMissingCountingKeysTest < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_find_handles_missing_oreb
      response = build_response_without("OREB")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.oreb
      assert_equal 5, stat.dreb
    end

    def test_find_handles_missing_dreb
      response = build_response_without("DREB")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.dreb
      assert_equal 1, stat.oreb
    end

    def test_find_handles_missing_reb
      response = build_response_without("REB")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.reb
      assert_equal 8, stat.ast
    end

    def test_find_handles_missing_ast
      response = build_response_without("AST")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.ast
      assert_equal 6, stat.reb
    end

    def test_find_handles_missing_tov
      response = build_response_without("TOV")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.tov
      assert_equal 8, stat.ast
    end

    def test_find_handles_missing_stl
      response = build_response_without("STL")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.stl
      assert_equal 3, stat.tov
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
