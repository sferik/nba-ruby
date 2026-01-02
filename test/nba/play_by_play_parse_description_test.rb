require_relative "../test_helper"

module NBA
  class PlayByPlayParseDescriptionTest < Minitest::Test
    cover PlayByPlay

    def test_parses_home_description
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal "Curry 3PT Jump Shot", play.home_description
    end

    def test_parses_neutral_description_when_present
      stub_play_by_play_with_descriptions

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal "Jump Ball", play.neutral_description
    end

    def test_parses_visitor_description_when_present
      stub_play_by_play_with_descriptions

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal "LeBron layup", play.visitor_description
    end

    def test_parses_neutral_description_when_nil
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_nil play.neutral_description
    end

    def test_parses_visitor_description_when_nil
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_nil play.visitor_description
    end

    def test_parses_score
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal "3 - 0", play.score
    end

    def test_parses_score_margin
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal "3", play.score_margin
    end

    def test_parses_video_available
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal 1, play.video_available
    end

    private

    def stub_play_by_play_request
      stub_request(:get, /playbyplayv2/).to_return(body: play_by_play_response.to_json)
    end

    def stub_play_by_play_with_descriptions
      stub_request(:get, /playbyplayv2/).to_return(body: play_by_play_with_descriptions_response.to_json)
    end

    def play_by_play_response
      {resultSets: [{name: "PlayByPlay", headers: play_headers, rowSet: [play_row]}]}
    end

    def play_by_play_with_descriptions_response
      {resultSets: [{name: "PlayByPlay", headers: play_headers, rowSet: [play_row_with_descriptions]}]}
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

    def play_row_with_descriptions
      ["0022400001", 1, 1, 0, 1, "7:00 PM", "12:00",
        "Curry 3PT Jump Shot", "Jump Ball", "LeBron layup", "3 - 0", "3",
        201_939, "Stephen Curry", Team::GSW, "GSW",
        nil, nil, nil, nil,
        nil, nil, nil, nil,
        1]
    end
  end
end
