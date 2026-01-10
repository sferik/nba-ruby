require_relative "../test_helper"

module NBA
  class PlayByPlayV3MissingFieldsTest < Minitest::Test
    cover PlayByPlayV3

    def test_find_handles_missing_player2_id
      response = build_response_without_headers("PLAYER2_ID")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.player2_id
      assert_equal "Karl-Anthony Towns", play.player2_name
    end

    def test_find_handles_missing_player2_name
      response = build_response_without_headers("PLAYER2_NAME")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.player2_name
      assert_equal 1_540_002, play.player2_id
    end

    def test_find_handles_missing_player2_team_id
      response = build_response_without_headers("PLAYER2_TEAM_ID")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.player2_team_id
      assert_equal "MIN", play.player2_team_abbreviation
    end

    def test_find_handles_missing_player2_team_abbreviation
      response = build_response_without_headers("PLAYER2_TEAM_ABBREVIATION")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.player2_team_abbreviation
      assert_equal Team::MIN, play.player2_team_id
    end

    def test_find_handles_missing_player3_id
      response = build_response_without_headers("PLAYER3_ID")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.player3_id
      assert_equal "Nikola Jokic", play.player3_name
    end

    def test_find_handles_missing_player3_name
      response = build_response_without_headers("PLAYER3_NAME")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.player3_name
      assert_equal 203_999, play.player3_id
    end

    def test_find_handles_missing_player3_team_id
      response = build_response_without_headers("PLAYER3_TEAM_ID")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.player3_team_id
      assert_equal "DEN", play.player3_team_abbreviation
    end

    def test_find_handles_missing_player3_team_abbreviation
      response = build_response_without_headers("PLAYER3_TEAM_ABBREVIATION")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.player3_team_abbreviation
      assert_equal Team::DEN, play.player3_team_id
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
