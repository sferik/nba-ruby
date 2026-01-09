require_relative "../test_helper"

module NBA
  class VideoDetailsMissingKeysTest < Minitest::Test
    cover VideoDetails

    def test_handles_missing_video_id_key
      headers = all_headers.reject { |h| h == "VIDEO_ID" }
      row = build_row_without("VIDEO_ID")
      response = {resultSets: [{name: "VideoDetails", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_nil video.video_id
    end

    def test_handles_missing_game_id_key
      headers = all_headers.reject { |h| h == "GAME_ID" }
      row = build_row_without("GAME_ID")
      response = {resultSets: [{name: "VideoDetails", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_nil video.game_id
    end

    def test_handles_missing_game_event_id_key
      headers = all_headers.reject { |h| h == "GAME_EVENT_ID" }
      row = build_row_without("GAME_EVENT_ID")
      response = {resultSets: [{name: "VideoDetails", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_nil video.game_event_id
    end

    def test_handles_missing_player_id_key
      headers = all_headers.reject { |h| h == "PLAYER_ID" }
      row = build_row_without("PLAYER_ID")
      response = {resultSets: [{name: "VideoDetails", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_nil video.player_id
    end

    def test_handles_missing_team_id_key
      headers = all_headers.reject { |h| h == "TEAM_ID" }
      row = build_row_without("TEAM_ID")
      response = {resultSets: [{name: "VideoDetails", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_nil video.team_id
    end

    def test_handles_missing_description_key
      headers = all_headers.reject { |h| h == "DESCRIPTION" }
      row = build_row_without("DESCRIPTION")
      response = {resultSets: [{name: "VideoDetails", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_nil video.description
    end

    def test_handles_missing_video_urls_key
      headers = all_headers.reject { |h| h == "VIDEO_URLS" }
      row = build_row_without("VIDEO_URLS")
      response = {resultSets: [{name: "VideoDetails", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_nil video.video_urls
    end

    def test_handles_missing_video_available_key
      headers = all_headers.reject { |h| h == "VIDEO_AVAILABLE" }
      row = build_row_without("VIDEO_AVAILABLE")
      response = {resultSets: [{name: "VideoDetails", headers: headers, rowSet: [row]}]}
      stub_request(:get, /videodetails/).to_return(body: response.to_json)

      video = VideoDetails.find(player: 1, team: 1, season: 2023).first

      assert_nil video.video_available
    end

    private

    def all_headers
      %w[VIDEO_ID GAME_ID GAME_EVENT_ID PLAYER_ID TEAM_ID DESCRIPTION VIDEO_URLS VIDEO_AVAILABLE]
    end

    def all_values
      {"VIDEO_ID" => "abc123", "GAME_ID" => "0022300001", "GAME_EVENT_ID" => 10, "PLAYER_ID" => 201_939,
       "TEAM_ID" => Team::GSW, "DESCRIPTION" => "Curry 3PT Jump Shot", "VIDEO_URLS" => "{\"720p\":\"url1\"}",
       "VIDEO_AVAILABLE" => 1}
    end

    def build_row_without(key)
      all_headers.reject { |h| h == key }.map { |h| all_values[h] }
    end
  end
end
