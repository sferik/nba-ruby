require_relative "../../test_helper"

module NBA
  class PlayByPlayV3GameFieldsTest < Minitest::Test
    cover PlayByPlayV3

    def test_find_handles_missing_game_id
      response = build_response_without_headers("GAME_ID")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.game_id
      assert_equal 1, play.event_num
    end

    def test_find_handles_missing_event_num
      response = build_response_without_headers("EVENTNUM")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.event_num
      assert_equal "0022400001", play.game_id
    end

    def test_find_handles_missing_event_msg_type
      response = build_response_without_headers("EVENTMSGTYPE")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.event_msg_type
      assert_equal "0022400001", play.game_id
    end

    def test_find_handles_missing_event_msg_action_type
      response = build_response_without_headers("EVENTMSGACTIONTYPE")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.event_msg_action_type
      assert_equal 12, play.event_msg_type
    end

    def test_find_handles_missing_period
      response = build_response_without_headers("PERIOD")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.period
      assert_equal "0022400001", play.game_id
    end

    def test_find_handles_missing_wc_time_string
      response = build_response_without_headers("WCTIMESTRING")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.wc_time_string
      assert_equal "12:00", play.pc_time_string
    end

    def test_find_handles_missing_pc_time_string
      response = build_response_without_headers("PCTIMESTRING")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.pc_time_string
      assert_equal "7:00 PM", play.wc_time_string
    end

    private

    def all_headers
      %w[GAME_ID EVENTNUM EVENTMSGTYPE EVENTMSGACTIONTYPE PERIOD WCTIMESTRING
        PCTIMESTRING HOMEDESCRIPTION NEUTRALDESCRIPTION VISITORDESCRIPTION SCORE
        SCOREMARGIN VIDEO_AVAILABLE_FLAG PLAYER1_ID PLAYER1_NAME PLAYER1_TEAM_ID
        PLAYER1_TEAM_ABBREVIATION PLAYER2_ID PLAYER2_NAME PLAYER2_TEAM_ID
        PLAYER2_TEAM_ABBREVIATION PLAYER3_ID PLAYER3_NAME PLAYER3_TEAM_ID
        PLAYER3_TEAM_ABBREVIATION]
    end

    def full_row
      ["0022400001", 1, 12, 0, 1, "7:00 PM", "12:00", "Jump Ball Adams vs. Towns",
        nil, nil, nil, nil, 1, 203_500, "Steven Adams", Team::OKC, "OKC",
        1_540_002, "Karl-Anthony Towns", Team::MIN, "MIN",
        203_999, "Nikola Jokic", Team::DEN, "DEN"]
    end

    def build_response_without_headers(*excluded)
      headers = all_headers.reject { |h| excluded.include?(h) }
      row = full_row.values_at(*all_headers.each_index.reject { |i| excluded.include?(all_headers[i]) })
      {resultSets: [{name: "PlayByPlay", headers: headers, rowSet: [row]}]}
    end
  end
end
