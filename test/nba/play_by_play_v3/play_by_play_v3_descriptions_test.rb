require_relative "../../test_helper"

module NBA
  class PlayByPlayV3DescriptionsTest < Minitest::Test
    cover PlayByPlayV3

    def test_find_handles_missing_home_description
      response = build_response_without_headers("HOMEDESCRIPTION")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.home_description
      assert_equal "0022400001", play.game_id
    end

    def test_find_handles_missing_neutral_description
      response = build_response_without_headers("NEUTRALDESCRIPTION")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.neutral_description
      assert_equal "Jump Ball Adams vs. Towns", play.home_description
    end

    def test_find_handles_missing_visitor_description
      response = build_response_without_headers("VISITORDESCRIPTION")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.visitor_description
      assert_equal "Jump Ball Adams vs. Towns", play.home_description
    end

    def test_find_handles_missing_score
      response = build_response_without_headers("SCORE")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.score
      assert_equal "0022400001", play.game_id
    end

    def test_find_handles_missing_score_margin
      response = build_response_without_headers("SCOREMARGIN")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.score_margin
      assert_equal "0022400001", play.game_id
    end

    def test_find_handles_missing_video_available_flag
      response = build_response_without_headers("VIDEO_AVAILABLE_FLAG")
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_nil play.video_available
      assert_equal "0022400001", play.game_id
    end

    def test_find_parses_neutral_description
      response = build_response_with_neutral_description
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "Timeout: Regular", play.neutral_description
    end

    def test_find_parses_visitor_description
      response = build_response_with_visitor_description
      stub_request(:get, /playbyplayv3/).to_return(body: response.to_json)

      play = PlayByPlayV3.find(game: "0022400001").first

      assert_equal "MISS Curry 3PT", play.visitor_description
    end

    private

    def build_response_with_neutral_description
      headers = all_headers
      row_with_neutral = full_row.dup
      neutral_index = headers.index("NEUTRALDESCRIPTION")
      row_with_neutral[neutral_index] = "Timeout: Regular"
      {resultSets: [{name: "PlayByPlay", headers: headers, rowSet: [row_with_neutral]}]}
    end

    def build_response_with_visitor_description
      headers = all_headers
      row_with_visitor = full_row.dup
      visitor_index = headers.index("VISITORDESCRIPTION")
      row_with_visitor[visitor_index] = "MISS Curry 3PT"
      {resultSets: [{name: "PlayByPlay", headers: headers, rowSet: [row_with_visitor]}]}
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

    def build_response_without_headers(*excluded)
      headers = all_headers.reject { |h| excluded.include?(h) }
      row = full_row.values_at(*all_headers.each_index.reject { |i| excluded.include?(all_headers[i]) })
      {resultSets: [{name: "PlayByPlay", headers: headers, rowSet: [row]}]}
    end
  end
end
