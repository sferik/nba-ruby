require_relative "../test_helper"

module NBA
  class PlayByPlayParsePlayerTest < Minitest::Test
    cover PlayByPlay

    def test_parses_player1_info
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal 201_939, play.player1_id
      assert_equal "Stephen Curry", play.player1_name
      assert_equal Team::GSW, play.player1_team_id
      assert_equal "GSW", play.player1_team_abbreviation
    end

    def test_parses_player2_info_when_present
      stub_play_by_play_with_all_players

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal 2544, play.player2_id
      assert_equal "LeBron James", play.player2_name
      assert_equal Team::LAL, play.player2_team_id
      assert_equal "LAL", play.player2_team_abbreviation
    end

    def test_parses_player2_info_when_absent
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_nil play.player2_id
      assert_nil play.player2_name
    end

    def test_parses_player3_info_when_present
      stub_play_by_play_with_all_players

      play = PlayByPlay.find(game: "0022400001").first

      assert_equal 203_507, play.player3_id
      assert_equal "Giannis Antetokounmpo", play.player3_name
      assert_equal Team::MIL, play.player3_team_id
      assert_equal "MIL", play.player3_team_abbreviation
    end

    def test_parses_player3_info_when_absent
      stub_play_by_play_request

      play = PlayByPlay.find(game: "0022400001").first

      assert_nil play.player3_id
      assert_nil play.player3_name
    end

    private

    def stub_play_by_play_request
      stub_request(:get, /playbyplayv2/).to_return(body: play_by_play_response.to_json)
    end

    def stub_play_by_play_with_all_players
      stub_request(:get, /playbyplayv2/).to_return(body: play_by_play_with_all_players_response.to_json)
    end

    def play_by_play_response
      {resultSets: [{name: "PlayByPlay", headers: play_headers, rowSet: [play_row]}]}
    end

    def play_by_play_with_all_players_response
      {resultSets: [{name: "PlayByPlay", headers: play_headers, rowSet: [play_row_with_all_players]}]}
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

    def play_row_with_all_players
      ["0022400001", 1, 1, 0, 1, "7:00 PM", "12:00",
        "Curry 3PT Jump Shot", nil, nil, "3 - 0", "3",
        201_939, "Stephen Curry", Team::GSW, "GSW",
        2544, "LeBron James", Team::LAL, "LAL",
        203_507, "Giannis Antetokounmpo", Team::MIL, "MIL",
        1]
    end
  end
end
