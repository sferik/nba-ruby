require_relative "../../test_helper"

module NBA
  class PlayByPlayV3PlayersTest < Minitest::Test
    cover PlayByPlayV3

    def test_find_parses_player1_id
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal 203_500, play.player1_id
    end

    def test_find_parses_player1_name
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "Steven Adams", play.player1_name
    end

    def test_find_parses_player1_team_id
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal Team::OKC, play.player1_team_id
    end

    def test_find_parses_player1_team_abbreviation
      stub_play_by_play_v3_request

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "OKC", play.player1_team_abbreviation
    end

    private

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
