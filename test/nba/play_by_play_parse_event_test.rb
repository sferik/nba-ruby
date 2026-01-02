require_relative "../test_helper"

module NBA
  class PlayByPlayParseEventTest < Minitest::Test
    cover PlayByPlay

    def test_parses_game_id
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal "0022400001", play.game_id
    end

    def test_parses_event_num
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal 1, play.event_num
    end

    def test_parses_event_msg_type
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal 1, play.event_msg_type
    end

    def test_parses_event_msg_action_type
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal 0, play.event_msg_action_type
    end

    def test_parses_period
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal 1, play.period
    end

    def test_parses_wc_time_string
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal "7:00 PM", play.wc_time_string
    end

    def test_parses_pc_time_string
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal "12:00", play.pc_time_string
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
        PLAYER1_ID PLAYER1_NAME PLAYER1_TEAM_ID PLAYER1_TEAM_ABBREVIATION
        PLAYER2_ID PLAYER2_NAME PLAYER2_TEAM_ID PLAYER2_TEAM_ABBREVIATION
        PLAYER3_ID PLAYER3_NAME PLAYER3_TEAM_ID PLAYER3_TEAM_ABBREVIATION
        VIDEO_AVAILABLE_FLAG]
    end

    def play_row
      ["0022400001", 1, 1, 0, 1, "7:00 PM", "12:00",
        "Curry 3PT Jump Shot", nil, nil, "3 - 0", "3",
        201_939, "Stephen Curry", Team::GSW, "GSW",
        nil, nil, nil, nil,
        nil, nil, nil, nil,
        1]
    end
  end
end
