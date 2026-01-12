require_relative "../../test_helper"

module NBA
  class PlayByPlayV3EdgeCasesTest < Minitest::Test
    cover PlayByPlayV3

    def test_find_handles_nil_response
      stub_request(:get, /playbyplayv3/).to_return(body: nil)

      result = PlayByPlayV3.find(game: "0022400001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_handles_empty_result_sets
      stub_request(:get, /playbyplayv3/).to_return(body: {resultSets: []}.to_json)

      result = PlayByPlayV3.find(game: "0022400001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      result = PlayByPlayV3.find(game: "0022400001")

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_find_parses_player2_id
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal 1_540_002, play.player2_id
    end

    def test_find_parses_player2_name
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "Karl-Anthony Towns", play.player2_name
    end

    def test_find_parses_player2_team_id
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal Team::MIN, play.player2_team_id
    end

    def test_find_parses_player2_team_abbreviation
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "MIN", play.player2_team_abbreviation
    end

    def test_find_parses_player3_id
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal 203_999, play.player3_id
    end

    def test_find_parses_player3_name
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "Nikola Jokic", play.player3_name
    end

    def test_find_parses_player3_team_id
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal Team::DEN, play.player3_team_id
    end

    def test_find_parses_player3_team_abbreviation
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "DEN", play.player3_team_abbreviation
    end

    def test_find_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "PlayByPlay", headers: all_headers, rowSet: [full_row]}
      ]}
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "0022400001", play.game_id
      assert_equal 1, play.event_num
    end

    private

    def stub_play_by_play_v3_request
      stub_request(:get, /playbyplayv3/).to_return(body: play_by_play_v3_response.to_json)
    end

    def play_by_play_v3_response
      {resultSets: [{name: "PlayByPlay", headers: all_headers, rowSet: [full_row]}]}
    end

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
  end
end
