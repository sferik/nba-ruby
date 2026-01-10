require_relative "../test_helper"

module NBA
  class InfographicFanDuelPlayerEdgeCasesTest < Minitest::Test
    cover InfographicFanDuelPlayer

    def test_find_handles_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = InfographicFanDuelPlayer.find(game: "0022400001", client: mock_client)

      assert_instance_of Collection, result
      assert_empty result
      mock_client.verify
    end

    def test_find_handles_empty_result_sets
      stub_request(:get, /infographicfanduelplayer/).to_return(body: {resultSets: []}.to_json)

      result = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      result = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_handles_empty_row_set
      response = {resultSets: [{name: "FanDuelPlayer", headers: fan_duel_headers, rowSet: []}]}
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      result = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_handles_missing_headers
      response = {resultSets: [{name: "FanDuelPlayer", rowSet: [fan_duel_row]}]}
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      result = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_handles_missing_row_set
      response = {resultSets: [{name: "FanDuelPlayer", headers: fan_duel_headers}]}
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      result = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_handles_result_sets_nil
      response = {resultSets: nil}
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      result = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_returns_empty_when_result_sets_key_missing
      stub_request(:get, /infographicfanduelplayer/).to_return(body: {}.to_json)

      result = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_returns_empty_when_result_set_name_key_missing
      response = {resultSets: [{headers: fan_duel_headers, rowSet: [fan_duel_row]}]}
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      result = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_empty result
    end

    def test_find_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "FanDuelPlayer", headers: fan_duel_headers, rowSet: [fan_duel_row]}
      ]}
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      stat = InfographicFanDuelPlayer.find(game: "0022400001").first

      assert_equal 201_939, stat.player_id
    end

    def test_find_uses_result_set_name_constant
      response = build_response_with_constant_name
      stub_request(:get, /infographicfanduelplayer/).to_return(body: response.to_json)

      result = InfographicFanDuelPlayer.find(game: "0022400001")

      assert_equal 1, result.size
    end

    private

    def build_response_with_constant_name
      {resultSets: [{name: InfographicFanDuelPlayer::FAN_DUEL_PLAYER,
                     headers: fan_duel_headers, rowSet: [fan_duel_row]}]}
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
