require_relative "../test_helper"

module NBA
  class PlayByPlayFindBasicTest < Minitest::Test
    cover PlayByPlay

    def test_find_returns_collection
      stub_play_by_play_request

      assert_instance_of Collection, PlayByPlay.find(game: "0022400001")
    end

    def test_find_uses_correct_game_id_in_path
      stub_play_by_play_request

      PlayByPlay.find(game: "0022400001")

      assert_requested :get, /playbyplayv2.*GameID=0022400001/
    end

    def test_find_uses_default_periods
      stub_play_by_play_request

      PlayByPlay.find(game: "0022400001")

      assert_requested :get, /playbyplayv2.*StartPeriod=1/
      assert_requested :get, /playbyplayv2.*EndPeriod=10/
    end

    def test_find_accepts_custom_periods
      stub_play_by_play_request

      PlayByPlay.find(game: "0022400001", start_period: 2, end_period: 4)

      assert_requested :get, /playbyplayv2.*StartPeriod=2/
      assert_requested :get, /playbyplayv2.*EndPeriod=4/
    end

    private

    def stub_play_by_play_request
      stub_request(:get, /playbyplayv2/).to_return(body: play_by_play_response.to_json)
    end

    def play_by_play_response
      {resultSets: [{name: "PlayByPlay", headers: play_headers, rowSet: [play_row]}]}
    end

    def play_headers
      %w[GAME_ID EVENTNUM EVENTMSGTYPE EVENTMSGACTIONTYPE PERIOD WCTIMESTRING PCTIMESTRING
        HOMEDESCRIPTION NEUTRALDESCRIPTION VISITORDESCRIPTION SCORE SCOREMARGIN
        PERSON1TYPE PLAYER1_ID PLAYER1_NAME PLAYER1_TEAM_ID PLAYER1_TEAM_CITY PLAYER1_TEAM_NICKNAME PLAYER1_TEAM_ABBREVIATION
        PERSON2TYPE PLAYER2_ID PLAYER2_NAME PLAYER2_TEAM_ID PLAYER2_TEAM_CITY PLAYER2_TEAM_NICKNAME PLAYER2_TEAM_ABBREVIATION
        PERSON3TYPE PLAYER3_ID PLAYER3_NAME PLAYER3_TEAM_ID PLAYER3_TEAM_CITY PLAYER3_TEAM_NICKNAME PLAYER3_TEAM_ABBREVIATION
        VIDEO_AVAILABLE_FLAG]
    end

    def play_row
      ["0022400001", 1, 1, 0, 1, "7:00 PM", "12:00",
        "Curry 3PT Jump Shot", nil, nil, "3 - 0", "3",
        1, 201_939, "Stephen Curry", Team::GSW, "Golden State", "Warriors", "GSW",
        0, nil, nil, nil, nil, nil, nil,
        0, nil, nil, nil, nil, nil, nil,
        1]
    end
  end
end
