require_relative "../../test_helper"

module NBA
  class InfographicFanDuelPlayerMissingIdentityKeysTest < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_find_handles_missing_player_id
      response = build_response_without("PLAYER_ID")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.player_id
      assert_equal "Stephen Curry", stat.player_name
    end

    def test_find_handles_missing_player_name
      response = build_response_without("PLAYER_NAME")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 201_939, stat.player_id
      assert_nil stat.player_name
    end

    def test_find_handles_missing_team_id
      response = build_response_without("TEAM_ID")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.team_id
      assert_equal "Warriors", stat.team_name
    end

    def test_find_handles_missing_team_name
      response = build_response_without("TEAM_NAME")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
      assert_nil stat.team_name
    end

    def test_find_handles_missing_team_abbreviation
      response = build_response_without("TEAM_ABBREVIATION")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
      assert_nil stat.team_abbreviation
    end

    def test_find_handles_missing_jersey_num
      response = build_response_without("JERSEY_NUM")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.jersey_num
      assert_equal "Stephen Curry", stat.player_name
    end

    def test_find_handles_missing_player_position
      response = build_response_without("PLAYER_POSITION")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.player_position
      assert_equal "Stephen Curry", stat.player_name
    end

    def test_find_handles_missing_location
      response = build_response_without("LOCATION")
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_nil stat.location
      assert_equal "Stephen Curry", stat.player_name
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
