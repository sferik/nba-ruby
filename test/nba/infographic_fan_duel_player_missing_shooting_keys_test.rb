require_relative "../test_helper"

module NBA
  class InfographicFanDuelPlayerMissingShootingKeysTest < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_find_handles_missing_fgm
      response = build_response_without("FGM")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.fgm
      assert_equal 20, stat.fga
    end

    def test_find_handles_missing_fga
      response = build_response_without("FGA")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.fga
      assert_equal 10, stat.fgm
    end

    def test_find_handles_missing_fg_pct
      response = build_response_without("FG_PCT")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.fg_pct
      assert_equal 10, stat.fgm
    end

    def test_find_handles_missing_fg3m
      response = build_response_without("FG3M")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.fg3m
      assert_equal 11, stat.fg3a
    end

    def test_find_handles_missing_fg3a
      response = build_response_without("FG3A")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.fg3a
      assert_equal 5, stat.fg3m
    end

    def test_find_handles_missing_fg3_pct
      response = build_response_without("FG3_PCT")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.fg3_pct
      assert_equal 5, stat.fg3m
    end

    def test_find_handles_missing_ftm
      response = build_response_without("FTM")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.ftm
      assert_equal 6, stat.fta
    end

    def test_find_handles_missing_fta
      response = build_response_without("FTA")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.fta
      assert_equal 5, stat.ftm
    end

    def test_find_handles_missing_ft_pct
      response = build_response_without("FT_PCT")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.ft_pct
      assert_equal 5, stat.ftm
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
