require_relative "../../test_helper"

module NBA
  class PlayByPlayV3Test < Minitest::Test
    cover PlayByPlayV3

    def test_find_returns_collection
      stub_play_by_play_v3_request

      assert_instance_of Collection, PlayByPlayV3.find(game: "0022400001")
    end

    def test_find_parses_game_id
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "0022400001", play.game_id
    end

    def test_find_parses_event_num
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal 1, play.event_num
    end

    def test_find_parses_event_msg_type
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal 12, play.event_msg_type
    end

    def test_find_parses_event_msg_action_type
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal 0, play.event_msg_action_type
    end

    def test_find_parses_period
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal 1, play.period
    end

    def test_find_parses_wc_time_string
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "7:00 PM", play.wc_time_string
    end

    def test_find_parses_pc_time_string
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "12:00", play.pc_time_string
    end

    def test_find_parses_home_description
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "Jump Ball Adams vs. Towns", play.home_description
    end

    def test_find_parses_video_available
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal 1, play.video_available
    end

    def test_find_parses_score
      stub_play_by_play_v3_with_score_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "102 - 98", play.score
    end

    def test_find_parses_score_margin
      stub_play_by_play_v3_with_score_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "4", play.score_margin
    end

    private

    def stub_play_by_play_v3_with_score_request
      stub_request(:get, /playbyplayv3/).to_return(body: play_by_play_v3_with_score_response.to_json)
    end

    def play_by_play_v3_with_score_response
      headers = %w[GAME_ID EVENTNUM EVENTMSGTYPE EVENTMSGACTIONTYPE PERIOD WCTIMESTRING
        PCTIMESTRING HOMEDESCRIPTION NEUTRALDESCRIPTION VISITORDESCRIPTION SCORE
        SCOREMARGIN VIDEO_AVAILABLE_FLAG PLAYER1_ID PLAYER1_NAME PLAYER1_TEAM_ID
        PLAYER1_TEAM_ABBREVIATION]
      row = ["0022400001", 50, 2, 1, 4, "9:45 PM", "3:30", "Tatum makes 3PT",
        nil, nil, "102 - 98", "4", 1, 1_628_369, "Jayson Tatum", Team::BOS, "BOS"]
      {resultSets: [{name: "PlayByPlay", headers: headers, rowSet: [row]}]}
    end

    def stub_play_by_play_v3_request
      stub_request(:get, /playbyplayv3/).to_return(body: play_by_play_v3_response.to_json)
    end

    def play_by_play_v3_response
      headers = %w[GAME_ID EVENTNUM EVENTMSGTYPE EVENTMSGACTIONTYPE PERIOD WCTIMESTRING
        PCTIMESTRING HOMEDESCRIPTION NEUTRALDESCRIPTION VISITORDESCRIPTION SCORE
        SCOREMARGIN VIDEO_AVAILABLE_FLAG PLAYER1_ID PLAYER1_NAME PLAYER1_TEAM_ID
        PLAYER1_TEAM_ABBREVIATION PLAYER2_ID PLAYER2_NAME PLAYER2_TEAM_ID
        PLAYER2_TEAM_ABBREVIATION PLAYER3_ID PLAYER3_NAME PLAYER3_TEAM_ID
        PLAYER3_TEAM_ABBREVIATION]
      row = ["0022400001", 1, 12, 0, 1, "7:00 PM", "12:00", "Jump Ball Adams vs. Towns",
        nil, nil, nil, nil, 1, 203_500, "Steven Adams", Team::OKC, "OKC",
        1_540_002, "Karl-Anthony Towns", Team::MIN, "MIN", nil, nil, nil, nil]
      {resultSets: [{name: "PlayByPlay", headers: headers, rowSet: [row]}]}
    end
  end
end
